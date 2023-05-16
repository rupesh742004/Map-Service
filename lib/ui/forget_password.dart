import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForrgetPassword extends StatefulWidget {
  const ForrgetPassword({Key? key}) : super(key: key);

  @override
  State<ForrgetPassword> createState() => _ForrgetPasswordState();
}

class _ForrgetPasswordState extends State<ForrgetPassword> {

  final emailControllar = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password '),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailControllar,
              decoration: const InputDecoration(
                hintText: 'Email id '
              ),
            ),
             SizedBox(height: 50,),
             RoundButton(title: 'forget',ontap: (){

              auth.sendPasswordResetEmail(email: emailControllar.text.toString()).then((value){
                utils().toastmassage('We have sent you email to recover password \n please check email ');
              }).onError((error, stackTrace) {
                utils().toastmassage(error.toString());
              });
            }),


          ],
        ),
      ),


    );
  }
}
