import 'package:copyfile/ui/auth/verify_code.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log in  '
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 100),
        child: Column(
          children: [
            TextFormField(
              controller: phoneNumberController,
              //keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+91 465 4989 856'
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: RoundButton(title: 'log in',loading: loading, ontap: (){

                setState(() {
                  loading = true;
                });

                  auth.verifyPhoneNumber(
                    phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_){

                        setState(() {
                          loading = false;
                        });

                      },
                      verificationFailed: (e){

                        setState(() {
                          loading = false;
                        });

                        utils().toastmassage(e.toString());
                      },
                      codeSent: (String verificationId ,int? token){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(verificationId:verificationId ,)));

                      setState(() {
                        loading = false;
                      });

                      },
                      codeAutoRetrievalTimeout: (e){
                        utils().toastmassage(e.toString());
                        setState(() {
                          loading = false;
                        });

                      });
              }),
            )
          ],

        ),
      ),

    );
  }
}
