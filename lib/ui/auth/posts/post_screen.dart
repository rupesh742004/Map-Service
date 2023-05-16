import 'dart:async';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  Completer<GoogleMapController> _controllar =Completer();

  static final  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(23.261534, 77.333395),
    zoom: 6,
  );


  List<Marker> _marker= [];
  List<Marker> _list=const [
    Marker(
        markerId: MarkerId('1'),
      position: LatLng(23.261534, 77.3333),
      infoWindow: InfoWindow(title: "my position")
    ),
    Marker(
        markerId: MarkerId('2'),
      position: LatLng(23.2615134, 77.33323),
      infoWindow: InfoWindow(title: "my position")
    ),

  ];



  void initState(){
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

       body:SafeArea(
         child: GoogleMap (
           initialCameraPosition: _kGooglePlex,
           mapType: MapType.normal,
           myLocationEnabled: true,
           compassEnabled: true,
           markers:Set<Marker>.of(_marker),
           onMapCreated: (GoogleMapController controllar){
             _controllar.complete(controllar);
           },
         ),
       ),

    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
    onPressed: () async {
          GoogleMapController controller= await _controllar.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target:LatLng(23.2615134, 77.33323),
              zoom: 10,
            ),
          ));
    },
    ),






    );
  }
}
/*
      Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Welcome \n Google map ', style: TextStyle(fontSize: 20 ),),
          ElevatedButton(onPressed: (){
             GoogleMap(initialCameraPosition: _kGooglePlex);

          }, child:Text('Goooogle map ') ),
          Container(
              height: 200,
              width: 200,
          ),



        ],
      )



      // Column(
      //   children: [
      //     Center(
      //       child: Container(
      //         child: ElevatedButton(onPressed: (){
      //            MyMap();
      //         }, child:Text('map') ),
      //       ),
      //     )
      //   ],
      // )

      // GoogleMap(initialCameraPosition: _kGooglePlex)

       */