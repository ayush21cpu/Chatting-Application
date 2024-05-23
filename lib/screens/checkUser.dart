import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatelessWidget {
  static const String id="CheckUser";
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return checkUser();
  }
  checkUser() {
    final user= FirebaseAuth.instance.currentUser;
    if(user!=null){
      return const ChatScreen();
    }else{
      return const WelcomeScreen();
    }
  }
}
