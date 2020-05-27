import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  final _textInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Type something..'),
                controller: _textInputController,
              ),
            ),
            IconButton(icon: Icon(Icons.send,color: ThemeData().primaryColor,), onPressed: () async{
              String _message = _textInputController.text;
              _textInputController.clear();
              if(_message.isEmpty){
                return;
              }
              FirebaseUser user = await FirebaseAuth.instance.currentUser();
              final userData = await Firestore.instance.collection('user').document(user.uid).get();
              Firestore.instance.collection('chats').add({
                'message' : _message.trim(),
                'timeStamp' : Timestamp.now(),
                'userId' : user.uid,
                'username' : userData['username']
              });

            })
          ],
        ),
      ),
    );
  }
}
