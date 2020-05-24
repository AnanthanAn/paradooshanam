import 'package:cloud_firestore/cloud_firestore.dart';
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
            IconButton(icon: Icon(Icons.send,color: ThemeData().primaryColor,), onPressed: () {
              String _message = _textInputController.text;
              if(_message.isEmpty){
                return;
              }
              Firestore.instance.collection('chats').add({
                'message' : _message.trim(),
                'timeStamp' : Timestamp.now(),
              });
              _textInputController.clear();
            })
          ],
        ),
      ),
    );
  }
}
