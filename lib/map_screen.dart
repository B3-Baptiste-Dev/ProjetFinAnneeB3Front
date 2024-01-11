import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  List<Marker> markers = [];
  double currentZoom = 13.0;
  static const double unCertainSeuil = 14.0;

  @override
  void initState() {
    super.initState();
    _fetchAnnonces(MapPosition(center: LatLng(50.4470, 3.2679), zoom: currentZoom), false);
  }

  void _fetchAnnonces(MapPosition position, bool hasGesture) async {
    if (hasGesture || !hasGesture) {
      if (position.zoom != null && position.zoom! > unCertainSeuil) {
        var bounds = position.bounds!;
        var url = Uri.parse('http://localhost:3000/annonces/area?latMin=${bounds.southWest!.latitude}&latMax=${bounds.northEast!.latitude}&longMin=${bounds.southWest!.longitude}&longMax=${bounds.northEast!.longitude}');
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var annonces = jsonDecode(response.body) as List;
          setState(() {
            markers = annonces.map((annonce) {
              var lat = double.parse(annonce['latitude'].toString());
              var lon = double.parse(annonce['longitude'].toString());
              var nomProduit = annonce['materiel']['nom'].toString();
              var idDemande = annonce['id'].toString();

              return Marker(
                width: 100.0,
                height: 100.0,
                point: LatLng(lat, lon),
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    print('ID de la demande: $idDemande');
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.red),
                      Text(nomProduit, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            }).toList();
          });
        }
      } else {
        setState(() {
          markers = [];
        });
      }
    }
  }

  void _searchAndNavigate() async {
    var response = await http.get(Uri.parse('https://nominatim.openstreetmap.org/search?format=json&q=${_searchController.text}'));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)[0];
      double lat = double.tryParse(result['lat'].toString()) ?? 0.0;
      double lon = double.tryParse(result['lon'].toString()) ?? 0.0;
      _mapController.move(LatLng(lat, lon), 13.0);
      _fetchAnnonces(MapPosition(center: LatLng(lat, lon), zoom: 13.0), false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(50.4470, 3.2679),
              zoom: currentZoom,
              onPositionChanged: _fetchAnnonces,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            left: 20.0,
            child: _buildSearchBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Chercher une ville',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: _searchAndNavigate,
          ),
        ),
        onSubmitted: (value) => _searchAndNavigate(),
      ),
    );
  }
}
