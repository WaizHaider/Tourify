import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

class OfflineMaps extends StatefulWidget {
  @override
  _OfflineMapsState createState() => _OfflineMapsState();
}

class _OfflineMapsState extends State<OfflineMaps> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Add your widget tree here
      body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition:
              CameraPosition(target: LatLng(30.3753, 69.3541))),
    );
  }
}
