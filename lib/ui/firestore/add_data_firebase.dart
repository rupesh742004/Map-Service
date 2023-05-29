import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:copyfile/user_corent_location.dart';

class AddDataFirebase extends StatefulWidget {
  const AddDataFirebase({Key? key}) : super(key: key);

  @override
  State<AddDataFirebase> createState() => _AddDataFirebaseState();
}

class _AddDataFirebaseState extends State<AddDataFirebase> {

  final commentcomtrollar = TextEditingController();
  final firestore = FirebaseDatabase.instance.ref('Comments');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add firebase data'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20 ),
        child: Form(

          child: Column(
            children: [
              SizedBox(height: 30,),
              TextFormField(
                maxLines: 5,
                keyboardType: TextInputType.text,
                controller: commentcomtrollar,
                decoration:  new InputDecoration(
                  labelText: " Comment",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),


                  // helperText: 'Enter email e.g abcd@gmail.com',

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter your problem';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40,),

              RoundButton(title: 'Add', ontap: (){
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                firestore.child(id).set({
                  'titel': commentcomtrollar.text.toString(),
                  'id'  : id ,


                }).then((value) {
                  utils().toastmassage('comment added ');
                }).onError((error, stackTrace) {
                  utils().toastmassage(error.toString());
                });

              })

            ],
          ),
        ),
      ),


    );
  }
}
