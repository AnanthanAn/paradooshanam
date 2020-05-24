
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paradooshanam/widgets/message_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:paradooshanam/widgets/send_message_widget.dart';

class ChatScreen extends StatefulWidget {


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.subscribeToTopic('chats');
    super.initState();
  }

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
