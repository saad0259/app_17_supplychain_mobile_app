import 'dart:async';
import 'dart:convert';
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
  late List<Marker> _markers= <Marker>[];
  final allMarkers= [[1,30.062, 72.36107569589637],[2,30.063, 72.36107569589637]];

  
  @override
  void initState() {
    // TODO: implement initState
    startAsyncInit();


    // for(var i in allMarkers){
    //
    //   _markers.add(Marker(
    //     markerId: MarkerId(i[0].toString()),
    //     draggable: false,
    //     onTap: (){
    //       print('Marker ${i[0]} was Tapped');
    //     },
    //     position: LatLng(i[1].toDouble(), i[2].toDouble()),
    //   ));
    // }

    // _markers.add(Marker(   //Add a single Marker
    //   markerId: MarkerId('id1'),
    //   draggable: false,
    // infoWindow: InfoWindow(
    //     title: 'The title of the marker'
    // ),
    //   onTap: (){
    //     print('Marker $MarkerId was Tapped');
    //   },
    //   position: LatLng(30.061, 72.36107569589637),
    // ));
    print("Maaaaaaarkkkkkkkkkkkkk0---------------------- $_markers");
  }

  Future startAsyncInit() async {
    setState(() async {
      final dealersData= await fetchDealers();
      print(dealersData);

      dealersData.forEach((k,v) => print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${k}: ${v}'));
      // for(var i in dealersData){
      //
      //   // print('TTTTTTTTTTTTTTTTTTTTyyyyyyyyyypeeeeeeeeeeeee ${i['latitude'].runtimeType}');
      //
      //   _markers.add(Marker(
      //     markerId: MarkerId(i['id'].toString()),
      //     draggable: false,
      //     infoWindow: InfoWindow(
      //         title: i['owner'],
      //     ),
      //     onTap: (){
      //       print('Marker ${i[0]} was Tapped');
      //     },
      //     position: LatLng(double.parse(i['latitude']), double.parse(i['longitude'])),
      //   ));
      //   print(_markers);
      // }

    });


  }

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
            markers: Set.from(_markers),

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



Future<Map> fetchDealers() async {
  final response =
  await http.get(Uri.parse('https://supply.techforgery.com/api/dealers'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //print(response.body);
    Map responseElements = jsonDecode(response.body);

    return responseElements;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
