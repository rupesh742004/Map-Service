import 'package:copyfile/Firebase_services/splas_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<SplashScreen> {
  @override
  SplashServices splashScreen = SplashServices();
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body:  Center(

        child: Text(
          'Welcome \n\n Women Safety ',
          style: TextStyle(fontSize: 40),


        ),
      ),
    );
  }
}
