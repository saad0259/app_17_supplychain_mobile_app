import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'business.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(30.049382740318542, 72.36107569589637),
    zoom: 14,

  );
  late GoogleMapController _googleMapController;

  @override
  void dispose(){
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller)=> _googleMapController=controller,
          ),
          FloatingActionButton(
              backgroundColor: Color(0xff009900),
              foregroundColor: Colors.white,
              child: Icon(Icons.center_focus_strong),
              onPressed: ()=> _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition),
              ),
          )
        ],
      ),

    );
  }
}
