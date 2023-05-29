import 'package:copyfile/ui/auth/signup_screen.dart';
import 'package:copyfile/ui/firestore/add_data_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FireSoretScreen extends StatefulWidget {
  const FireSoretScreen({Key? key}) : super(key: key);

  @override
  State<FireSoretScreen> createState() => _FireSoretScreenState();
}

class _FireSoretScreenState extends State<FireSoretScreen> {

  final auth = FirebaseAuth.instance;
  final ref =FirebaseDatabase.instance.ref('Comments');

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire store '),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(

            child: FirebaseAnimatedList(

                query: ref,
                defaultChild: Text('loading'),
                itemBuilder: (context, snapshot, animation, index){
                  return ListTile(

                    title: Text(snapshot.child('titel').value.toString()),

                  );
                }
            ),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddDataFirebase() ));

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
