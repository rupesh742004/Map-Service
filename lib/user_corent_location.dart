import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copyfile/ui/auth/login_screeen.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocatinScreen extends StatefulWidget {
  const GetUserCurrentLocatinScreen({Key? key}) : super(key: key);

  @override
  State<GetUserCurrentLocatinScreen> createState() =>
      _GetUserCurrentLocatinScreenState();
}

class _GetUserCurrentLocatinScreenState
    extends State<GetUserCurrentLocatinScreen> {

  final Completer<GoogleMapController> _controllar = Completer();

  static const CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(23.18233, 77.419771),
    zoom: 6,
  );

  final List<Marker> _marker = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(23.18092, 77.41491),
      infoWindow: InfoWindow(title: "my position"),
    )
  ];

  lodedata() {
    getUserCurrentLocatio().then((value) async {
      print("my current location -> " +
          value.latitude.toString() +
          "  " +
          value.longitude.toString());

      _marker.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: "my current location",
          )));

      CameraPosition cameraPosition = CameraPosition(
          zoom: 16, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controllar.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  } //lode data

  Future<Position> getUserCurrentLocatio() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lodedata();
  }


  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Gooogle Map'),
        centerTitle: true,
        // actions: [
        //   Align(child: IconButton(onPressed: () {
        //     auth.signOut().then((value) {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        //     }).onError((error, stackTrace){
        //       utils().toastmassage(error.toString());
        //     });
        //
        //   }, icon: Icon(Icons.logout))),
        // ],
      ),
      body: Container(
        height: 634,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controllar) {
            _controllar.complete(controllar);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () async {
          try{
              getUserCurrentLocatio().then((value) async {
              print("my current location -> " +value.latitude.toString() +"  " + value.longitude.toString());


                String id = DateTime.now().millisecondsSinceEpoch.toString();
                FirebaseFirestore.instance.collection('Curentlocation').doc(id).set({
                  'latitud': value.latitude.toString(),
                  'logitud': value.longitude.toString(),
                });

                 });



          }catch(e){
            print(e);
          }

        },
      ),

      // show your location in map  =-->

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.location_searching),
      //   onPressed: () async {
      //     getUserCurrentLocatio().then((value) async {
      //       print("my current location -> " +
      //           value.latitude.toString() +
      //           "  " +
      //           value.longitude.toString());
      //
      //       _marker.add(Marker(
      //           markerId: MarkerId('2'),
      //           position: LatLng(value.latitude, value.longitude),
      //           infoWindow: InfoWindow(
      //             title: "my current location",
      //           )));
      //
      //       CameraPosition cameraPosition = CameraPosition(
      //           zoom: 16, target: LatLng(value.latitude, value.longitude));
      //
      //       final GoogleMapController controller = await _controllar.future;
      //
      //       controller
      //           .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      //       setState(() {});
      //     });
      //
      //   },
      // ),
    );
  }
}
