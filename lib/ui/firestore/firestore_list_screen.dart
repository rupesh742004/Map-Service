import 'package:copyfile/ui/auth/signup_screen.dart';
import 'package:copyfile/ui/firestore/add_data_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireSoretScreen extends StatefulWidget {
  const FireSoretScreen({Key? key}) : super(key: key);

  @override
  State<FireSoretScreen> createState() => _FireSoretScreenState();
}

class _FireSoretScreenState extends State<FireSoretScreen> {

  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire store '),
        centerTitle: true,
      ),

      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                return ListTile(title:Text('rohit ') ,);
              })

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
