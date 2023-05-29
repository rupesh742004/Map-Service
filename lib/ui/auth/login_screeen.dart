import 'package:copyfile/home_buttons.dart';
import 'package:copyfile/ui/auth/login_with_number.dart';
import 'package:copyfile/ui/auth/posts/post_screen.dart';
import 'package:copyfile/ui/auth/signup_screen.dart';
import 'package:copyfile/ui/forget_password.dart';
import 'package:copyfile/user_corent_location.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }


  void login(){

    _auth.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text.toString()).then((value){

          utils().toastmassage(value.user!.email.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeButtons()));



    }).onError((error, stackTrace){

      debugPrint(error.toString());
      utils().toastmassage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
         resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: Text('Log in')),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text("Welcome ",style: TextStyle(color: Colors.deepPurpleAccent ,fontSize: 50,),),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              // helperText: 'Enter email e.g abcd@gmail.com',
                              prefixIcon: Icon(Icons.mark_email_read_outlined),

                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter email';
                            }
                            return null;
                          },
                        ),
                      ),


                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: passwordcontroller,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          // helperText: 'Enter email e.g abcd@gmail.com',
                          prefixIcon: Icon(Icons.fingerprint),

                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> ForrgetPassword())
                      );
                    },
                        child: Text('Forget password ?')),
                  ),
                ),

                RoundButton(
                  title: "Log in",
                  ontap: () {
                    if (_formKey.currentState!.validate()) {

                      login();
                    }
                  },
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Don't have an account? "),
                      TextButton(onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> SignupScreen())
                        );
                      }, child: Text('Sign up'))
                    ],
                  ),
                ),


                InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>LoginWithPhoneNumber() ));
                  },
                  child: Padding(

                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      height: 50,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black54
                        )
                      ),
                      child: Center(

                        child: Text(' phone  number'),
                      ),
                    ),
                  ),
                )


              ],
            ),
          )
      ),
    );
  }
}
