import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/checkUser.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBVL4VGG8aaxJXaTNle38zqZo5y_hm21fg',
          appId: '1:239435972827:android:54198697066b40704b4cfe',
          messagingSenderId: '239435972827',
          projectId: 'flash-chat-9a',
          storageBucket: 'flash-chat-9a.appspot.com',
        )
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     initialRoute:CheckUser.id,
      routes: {
        CheckUser.id:(context)=>const CheckUser(),
        WelcomeScreen.id: (context)=>const WelcomeScreen(),
        LoginScreen.id: (context)=>const LoginScreen(),
        RegistrationScreen.id: (context)=>const RegistrationScreen(),
        ChatScreen.id: (context)=>const ChatScreen(),
      },
    );
  }
}