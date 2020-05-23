import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: Firestore.instance.collection('chats').snapshots(),builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> querySnapshot) {
        if(querySnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        final docs = querySnapshot.data.documents;
        return ListView.builder(
          itemBuilder: (ctx, index) => Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(docs[index]['message']),
            ),
          ),
          itemCount:docs.length,
        );
      }

      ),
    );
  }
}
