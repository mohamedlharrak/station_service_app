import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Station Service App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    _fetchStations();
  }

  Future<void> _fetchStations() async {
    try {
      final response = await http
          .get(Uri.parse('http://10.0.2.2/station_service_app/api.php'));

      if (response.statusCode == 200) {
        final stations = json.decode(response.body);
        setState(() {
          _markers.clear();
          for (final station in stations) {
            final marker = Marker(
              markerId: MarkerId(station['id'].toString()),
              position: LatLng(station['latitude'], station['longitude']),
              infoWindow: InfoWindow(
                title: station['nom_station'],
                snippet:
                    'Diesel: ${station['prix_diesel']} €, Essence: ${station['prix_essence']} €',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StationDetailScreen(station: station),
                    ),
                  );
                },
              ),
            );
            _markers[station['id'].toString()] = marker;
          }
        });
      } else {
        throw Exception('Failed to load stations');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stations de Service'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(35.7595, -5.8339),
          zoom: 12,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchCityScreen(),
            ),
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class SearchCityScreen extends StatefulWidget {
  @override
  _SearchCityScreenState createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _stations = [];

  Future<void> _fetchStations(String ville) async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2/station_service_app/api.php?ville=$ville'));

      if (response.statusCode == 200) {
        setState(() {
          _stations = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load stations');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rechercher par Ville'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Entrez le nom de la ville',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _fetchStations(_controller.text);
              },
              child: Text('Rechercher'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _stations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(_stations[index]['logo_url']),
                    title: Text(_stations[index]['nom_station']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StationDetailScreen(station: _stations[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StationDetailScreen extends StatelessWidget {
  final dynamic station;

  StationDetailScreen({required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station['nom_station']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prix du Diesel: ${station['prix_diesel']} DH'),
            Text('Prix de l\'Essence: ${station['prix_essence']} DH'),
            Text('Prix des Services: ${station['prix_services']}'),
          ],
        ),
      ),
    );
  }
}
