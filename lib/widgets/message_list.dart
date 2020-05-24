import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paradooshanam/widgets/message_bubble.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('chats')
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder:
            (BuildContext ctx, AsyncSnapshot<QuerySnapshot> querySnapshot) {
          if (querySnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = querySnapshot.data.documents;
          return ListView.builder(reverse: true,
            itemBuilder: (ctx, index) => Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: MessageBubble(docs[index]['message']),
              ),
            ),
            itemCount: docs.length,
          );
        });
  }
}
