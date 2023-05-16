import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart 'as  http;

class GooglePlaceApiScreen extends StatefulWidget {
  const GooglePlaceApiScreen({Key? key}) : super(key: key);

  @override
  State<GooglePlaceApiScreen> createState() => _GooglePlaceApiScreenState();
}

class _GooglePlaceApiScreenState extends State<GooglePlaceApiScreen> {

  TextEditingController _controller=TextEditingController();
  var uuid = Uuid();
  String _sessionToken  ='122344';
  
  List<dynamic> _pleceList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void  onChange(){
    if(_sessionToken==null){
      setState(() {
        _sessionToken=uuid.v4();
      });
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input)async{
    String kPLACES_API_KEY = "AIzaSyDj28V785a82kAE0tmEDFEEoCE-NtUatsU";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var responce = await http.get(Uri.parse(request));
    print(responce);
    
    if (responce.statusCode == 200){
      setState(() {
        //_pleceList = JsonDecoder(responce.body.toString())['prediction'];
      });
      
    }else{
      throw Exception('Faild to lode data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('google search api'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(

                  hintText: "Search place "
              ),
            )
          ],

        ),
      ),

    );
  }


}
