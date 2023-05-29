import 'package:background_sms/background_sms.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class SandSMSWithLiveLocation extends StatefulWidget {
  const SandSMSWithLiveLocation({Key? key}) : super(key: key);

  @override
  State<SandSMSWithLiveLocation> createState() => _SandSMSWithLiveLocationState();
}

class _SandSMSWithLiveLocationState extends State<SandSMSWithLiveLocation> {


  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;


  _getPermission() async => await Permission.sms.request();
  _isPermissionGranted() async => await Permission.sms.isGranted;

_sendSMS(String phonenumber ,String massage ,{int? simSlote})async{

  await BackgroundSms.sendMessage(
      phoneNumber: phonenumber,
      message: massage,
      simSlot: simSlote,
  ).then((SmsStatus status){
    if (status == "sent") {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: " ");
    }
  }).onError((error, stackTrace){
    utils().toastmassage(error.toString());
  });

}

  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "permission denid");
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: "permission permanetly denid");
      }
    }
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true
    ).then((Position position) {
      setState(() {
        _curentPosition = position;
        _getAddressFormLetLon();
      });
    }).catchError((e){
        Fluttertoast.showToast(msg: e.toString());
      });
  }

  _getAddressFormLetLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_curentPosition!.latitude, _curentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _curentAddress = "${place.locality},${place.postalCode},${place.country}";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());


    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    _getPermission();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Get location & Send SMS"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Send SMS',style: TextStyle(fontSize: 30),),

          if (_curentPosition != null) Text(_curentAddress!),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
            child: RoundButton(title: "Get location", ontap: (){
              _getCurrentLocation();
              print(_getCurrentLocation());
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
            child: RoundButton(title: "Send  alert",
                ontap: ()async{
              String recipients = "11";

              String messageBody ="https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress/police stations near me";

              if(await _isPermissionGranted()){

                _sendSMS(
                    "9302765839","i am in truble place help me \n my location $messageBody" ,
                simSlote: 1
                );

              }else{
                Fluttertoast.showToast(msg: "massge not send");
              }



            }),
          )
        ],
      )

    );
  }
}
