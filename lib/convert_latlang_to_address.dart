// convert the  latilang to address


import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLetLangToAddress extends StatefulWidget {
  const ConvertLetLangToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLetLangToAddress> createState() => _ConvertLetLangToAddressState();
}

class _ConvertLetLangToAddressState extends State<ConvertLetLangToAddress> {

  String stAddress = '', stAdd ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Google map'),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),

          GestureDetector(
            onTap: () async {

              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
              // From a query
              //final query = "1600 Amphiteatre Parkway, Mountain View";

             // final coordinates= new Coordinates(23.2599, 77.4126);


              setState(() {
                    stAddress=locations.last.longitude.toString()+""+locations.last.longitude.toString();
                    stAdd= placemarks.reversed.last.country.toString()+" "+placemarks.reversed.last.locality.toString()+" "+placemarks.reversed.last.subAdministrativeArea.toString();
              });


            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: 
                Center(
                  child: Text('convert'),
                ),
              ),
            ),
          )

        ],

      ),



    );
  }
}
