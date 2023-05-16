import 'package:copyfile/user_corent_location.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'verify  '
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 100),
        child: Column(
          children: [
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '6 digit code'
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: RoundButton(title: 'verify ',loading: loading, ontap: ()async{

                setState(() {
                  loading = true;
                });


                final crendital = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: verificationCodeController.toString());
                try{
                  await auth.signInWithCredential(crendital);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> GetUserCurrentLocatinScreen()));

                }catch(e){
                  setState(() {
                    loading = true;
                    utils().toastmassage(e.toString());
                  });

                }

              }),
            )
          ],

        ),
      ),

    );
  }
}
