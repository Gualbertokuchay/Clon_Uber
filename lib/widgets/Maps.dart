import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapSample extends StatefulWidget {
  const MapSample();

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Position? _currentPosition;
  TextEditingController _destinationController = TextEditingController();
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyD4GIsFoH0ythpRPUIeThu5fkWJDrw2NH8');

  bool isSearchingLocation = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (_currentPosition != null) {
      final target = LatLng(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      await controller.animateCamera(CameraUpdate.newLatLng(target));
    }
  }

  Future<void> _goToDestination() async {
    final GoogleMapController controller = await _controller.future;
    final response = await _places.searchByText(_destinationController.text);
    if (response.status == 'OK' && response.results.isNotEmpty) {
      final destination = response.results[0].geometry?.location;
      await controller
          .animateCamera(CameraUpdate.newLatLng(destination as LatLng));

      if (_currentPosition != null && destination != null) {
        PolylineResult result = await _getPolyline(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          destination as LatLng,
        );

        if (result.points.isNotEmpty) {
          _addPolyline(controller, result.points);
        }
      }
    }
  }

  Future<PolylineResult> _getPolyline(LatLng origin, LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyD4GIsFoH0ythpRPUIeThu5fkWJDrw2NH8',
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    return result;
  }

  void _addPolyline(GoogleMapController controller, List<PointLatLng> points) {
    List<LatLng> polylineCoordinates = [];

    points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: polylineCoordinates.first,
          northeast: polylineCoordinates.last,
        ),
        50,
      ),
    );
  }

  void _toggleSearchLocation() {
    setState(() {
      isSearchingLocation = !isSearchingLocation;
    });
    if (!isSearchingLocation) {
      _goToDestination();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Planifica tu viaje',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _currentPosition != null
                    ? CameraPosition(
                        target: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                        zoom: 14.0,
                      )
                    : CameraPosition(
                        target: LatLng(20.584220, -90.001480),
                        zoom: 14.0,
                      ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: FloatingActionButton(
                  onPressed: _goToCurrentLocation,
                  backgroundColor: const Color.fromARGB(255, 241, 241, 241),
                  child: const Icon(Icons.my_location),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 1,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: _buildCuadroConIconos(
                              'Iniciar el Viaje Ahora',
                              Icons.access_time,
                              Icons.arrow_drop_down,
                            ),
                          ),
                          SizedBox(width: 2),
                          Expanded(
                            flex: 1,
                            child: _buildCuadroConIconos(
                              'Para Mí',
                              Icons.person,
                              Icons.arrow_drop_down,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            isSearchingLocation
                                ? Icons.circle_outlined
                                : Icons.check_box_outline_blank,
                            color: Color.fromARGB(255, 5, 5, 5),
                          ),
                          Expanded(
                            child: Container(
                              height: 35,
                              child: TextField(
                                decoration: InputDecoration(
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  hintText: 'Ubicación Actual',
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    color:
                                        const Color.fromARGB(255, 14, 13, 13),
                                    icon: Icon(Icons.search),
                                    onPressed: _toggleSearchLocation,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            isSearchingLocation
                                ? Icons.check_box_outline_blank
                                : Icons.circle_outlined,
                            color: const Color.fromARGB(255, 33, 33, 34),
                          ),
                          Expanded(
                            child: Container(
                              height: 35,
                              child: TextField(
                                controller: _destinationController,
                                decoration: InputDecoration(
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  hintText: '¿A dónde vas?',
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.search),
                                    onPressed: _toggleSearchLocation,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCuadroConIconos(String texto, IconData icono1, IconData icono2) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 232, 232),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icono1),
          ),
          Expanded(
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icono2),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapSample(),
  ));
}
