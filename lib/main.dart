import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paradooshanam/screens/auth_screen.dart';
import 'package:paradooshanam/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradooshanam',
      theme: ThemeData(

        primaryColor: Colors.lime,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (context, userSnapshot) {
        if(userSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }

        if(userSnapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      },),
    );
  }
}

