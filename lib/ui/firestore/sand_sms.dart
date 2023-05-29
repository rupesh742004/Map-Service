import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class SandSMSCallEmail extends StatefulWidget {
  const SandSMSCallEmail({Key? key}) : super(key: key);

  @override
  State<SandSMSCallEmail> createState() => _SandSMSCallEmailState();
}

class _SandSMSCallEmailState extends State<SandSMSCallEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Send "),
    ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             ElevatedButton(onPressed: (){
               launch('tel: +91 7879056713');

            }, child: Text("Make call")),


             ElevatedButton(onPressed: (){
               launch('sms: +91 7879056713?body=hii ');

            }, child: Text("send SMS ")),


             ElevatedButton(onPressed: (){
               launch('mailto: rahangdalerupesh143@gmail.com ');

            }, child: Text("Make mail ")),


             ElevatedButton(onPressed: (){
               launch('https://rgpv.com ');

            }, child: Text("url ")),

          ],
        ),
      ),

    );

  }
}
