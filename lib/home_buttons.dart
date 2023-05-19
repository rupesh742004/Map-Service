import 'package:copyfile/ui/auth/login_screeen.dart';
import 'package:copyfile/ui/firestore/add_data_firebase.dart';
import 'package:copyfile/ui/firestore/firestore_list_screen.dart';
import 'package:copyfile/ui/firestore/shake_phone.dart';
import 'package:copyfile/ui/uplode_image.dart';
import 'package:copyfile/user_corent_location.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:copyfile/ui/auth/login_screeen.dart';

class HomeButtons extends StatefulWidget {
  const HomeButtons({Key? key}) : super(key: key);

  @override
  State<HomeButtons> createState() => _HomeButtonsState();
}

class _HomeButtonsState extends State<HomeButtons> {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Icon(Icons.home_outlined),
        actions: [
          Align(child: IconButton(onPressed: () {
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace){
              utils().toastmassage(error.toString());
            });

          }, icon: Icon(Icons.logout))),
        ],
      ),

      body: Container(


        decoration: const BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/icon/protect.png"),
          //     fit: BoxFit.cover),
          color: Colors.blueGrey
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(title: "My Location", ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> GetUserCurrentLocatinScreen()));
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(title: "Uplode Image ", ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UplodeImage()));
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(title: "Add comment ", ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FireSoretScreen()));
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(title: "Shake phone ", ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ShakePhone()));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
