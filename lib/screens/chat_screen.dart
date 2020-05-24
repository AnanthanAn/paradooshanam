
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paradooshanam/widgets/message_list.dart';
import 'package:paradooshanam/widgets/send_message_widget.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paradooshanam'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              })
        ],
      ),
      body:Column(children: <Widget>[
        Expanded(child: MessageList()),
        SendMessage()
      ],)
    );
  }
}
