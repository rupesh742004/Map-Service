import 'dart:io';

import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:camera/camera.dart';



class UplodeImage extends StatefulWidget {
  const UplodeImage({Key? key}) : super(key: key);

  @override
  State<UplodeImage> createState() => _UplodeImageState();
}

class _UplodeImageState extends State<UplodeImage> {
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseref = FirebaseDatabase.instance.ref('post');


  Future getImagegallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('image not selected ');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('uplode image'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImagegallery();
                },
                child: Container(
                  height: 150,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black45)),
                  child:

                  _image != null
                      ? Image.file(_image!.absolute)
                      : Icon(Icons.image),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
              child: RoundButton(
                  title: 'uplode',
                  ontap: () async {
                    String id = DateTime.now().millisecondsSinceEpoch.toString();
                    firebase_storage.Reference ref = firebase_storage .FirebaseStorage.instance.ref('Photos/images'+id);
                    firebase_storage.UploadTask uplodetask =ref.putFile(_image!.absolute);

                     Future.value(uplodetask).then((value) {
                      var newurl = ref.getDownloadURL();
                      databaseref.child(id).set({
                        'id': id,
                        'title':newurl.toString(),
                      });
                      utils().toastmassage("Uploded");

                    }).onError((error, stackTrace) {
                      utils().toastmassage(error.toString());
                    });




                  }),
            )
          ],
        ),
      ),
    );
  }
}
