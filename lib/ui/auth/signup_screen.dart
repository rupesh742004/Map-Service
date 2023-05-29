import 'package:copyfile/ui/auth/login_screeen.dart';
import 'package:copyfile/utils/utils.dart';
import 'package:copyfile/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void Signup(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passwordcontroller.text.toString()).then((value){
      setState(() {
        loading = false;
      });

    }).onError((error, stackTrace){
      utils().toastmassage(error.toString());
      setState(() {
        loading = false;
      });

    });
  }
  Future<void> sandEmailVerification()async{
    try{
      await   _auth.currentUser?.sendEmailVerification();
    }catch(e){
      print(e);
      utils().toastmassage(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Sign up')),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,

                        decoration: const InputDecoration(
                          hintText: 'Full Name ',
                          // helperText: 'Enter email e.g abcd@gmail.com',
                          prefixIcon: Icon(Icons.border_color_outlined),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          // helperText: 'Enter email e.g abcd@gmail.com',
                          prefixIcon: Icon(Icons.email_sharp),
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
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          // helperText: 'Enter email e.g abcd@gmail.com',
                          prefixIcon: Icon(Icons.lock_outline_sharp)
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
              const SizedBox(
                height: 70,
              ),
              RoundButton(
                title: "Sign up",
                loading: loading,
                ontap: () {
                  if (_formKey.currentState!.validate()) {
                     Signup();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text('log in'))
                ],
              )
            ],
          ),
        ));
  }
}
