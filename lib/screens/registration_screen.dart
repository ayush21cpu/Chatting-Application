import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Styles/button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isLoading=false;


//ye ham registration OR singUp ke liye kiye hai ki jb singUp wale btn pr click hoga then kase and kya hoga for singUp
  void registration(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      print("Enter required fields");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
         Navigator.pushNamed(context, ChatScreen.id);
      } on FirebaseAuthException catch (e) {
        print(e.code.toString());
      }finally{
        setState(() {
          _isLoading=false; //jab ya to singIn ho jaye ya error de tab tak chle ga uske bad ruk jaye ga
        });
      }
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
            Flexible(
              child: Hero(
                tag: "flashIcon",
                child: Container(
                  height: 200,
                  child: Image.asset('assets/images/flassh.png'),
                ),
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
            _isLoading?Center(
              child: LoadingAnimationWidget.inkDrop(color: Colors.blueAccent, size: 50),
            ):
            btn(
              colour: Colors.blueAccent,
              onPressed: () {
                setState(() {
                  _isLoading=true;
                });
                registration(email.text.trim(), password.text.trim());
              },
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    super.key,
    required this.ctrl,
    required this.hint,
    required this.icn,
    required this.bol,
    required this.kType,
  });

  final TextEditingController ctrl;
  final String hint;
  final Icon icn;
  final bool bol;
  final TextInputType kType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: kType,
      textAlign: TextAlign.center,
      obscureText: bol,
      style: const TextStyle(
        color: Colors.white,
      ),
      controller: ctrl,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: icn,
        suffixIconColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.white54),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
