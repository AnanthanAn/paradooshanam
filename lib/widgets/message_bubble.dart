import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;

  MessageBubble(this._message);
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.teal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(_message),
      ),
    );
  }
}
