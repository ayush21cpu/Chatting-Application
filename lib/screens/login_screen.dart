import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Styles/button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
   static const String id='login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var email=TextEditingController();
  var password=TextEditingController();
  bool _isLoading = false;





  // yaha bhi hamne registration wale page ka jase hi singIn ka ek function bna kr usko onPressed me pass kiya
  void singIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential != null){
      Navigator.pushNamed(context, ChatScreen.id);
    }} on FirebaseAuthException catch(e){
      print (e);
    }  finally {
    setState(() {
    _isLoading = false; // Hide the loading indicator
  });
  }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: "flashIcon",
                child: Container(
                  height: 200,
                  child: Image.asset('assets/images/flassh.png'),
                ),
              ),
              const SizedBox(height: 48.0),
              TextFields(
                ctrl: email,
                hint: "Email",
                icn: const Icon(Icons.email),
                bol: false,
                kType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 28),
              TextFields(
                ctrl: password,
                hint: "Password",
                icn: const Icon(Icons.lock),
                bol: true,
                kType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 48.0),
              _isLoading // Show the loading indicator if loading
                  ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.blueAccent,
                  size: 50,
                ),
              )
                  : btn(  colour: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    _isLoading = true; // Show the loading indicator
                  });
                  // LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 60);
                  singIn(email.text.trim(), password.text.trim());
                },
                title: 'Log In',
              ),

            ],
          ),
        ),
      );
  }
}
