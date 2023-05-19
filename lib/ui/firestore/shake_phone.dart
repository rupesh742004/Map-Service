import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shake/shake.dart';

class ShakePhone extends StatefulWidget {
  const ShakePhone({Key? key}) : super(key: key);

  @override
  State<ShakePhone> createState() => _ShakePhoneState();
}

class _ShakePhoneState extends State<ShakePhone> {
  int Shakecount = 0;

  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;

  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
        "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //
  // String recipients = "";
  // List<TContact> contactList =
  //     await DatabaseHelper().getContactList();
  // print(contactList.length);
  // if (contactList.isEmpty) {
  // Fluttertoast.showToast(
  // msg: "emergency contact is empty");
  // } else {
  // String messageBody =
  // "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";
  //
  // if (await _isPermissionGranted()) {
  // contactList.forEach((element) {
  // _sendSms("${element.number}",
  // "i am in trouble $messageBody");
  // });
  // } else {
  // Fluttertoast.showToast(msg: "something wrong");
  // }
  // }

  @override
  Widget build(BuildContext context) {
    ShakeDetector.autoStart(onPhoneShake: () {
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
           content : Text("Shake !"),
         ),
      );

      setState(() {
        Shakecount++;
  QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            text: ' your chutiya ',
            confirmBtnText: 'Yes',

            confirmBtnColor: Colors.green,
          );

      });
    },

      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,





    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Shake phone "),
      ),
      body: Center(
        child: Text("Shake phone $Shakecount"),
      ),

    );
  }
}
