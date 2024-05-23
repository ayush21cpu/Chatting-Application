
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import '../Styles/button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animatinoController;
  @override
  void initState() {
    super.initState();
    animatinoController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animatinoController.forward();
    animatinoController.addListener(() {
      print(animatinoController.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: "flashIcon",
                      child: Container(
                        height: 80,
                        child: Image.asset('assets/images/flassh.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 45.0,
                        fontWeight:FontWeight.w900,
                      ),
                      child: AnimatedTextKit(

                        animatedTexts: [
                          TypewriterAnimatedText('Flash Chat'),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              btn(colour: Colors.lightBlueAccent, onPressed: (){ Navigator.pushNamed(context, LoginScreen.id);}, title:"Log In"),
               const SizedBox(
                height: 30,
              ),
              btn(colour:Colors.blueAccent , onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              }, title: "Register"),
            ],
          ),
        ),
      ),
    );
  }
}
