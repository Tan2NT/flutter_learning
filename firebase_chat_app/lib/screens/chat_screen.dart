import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/0zf2EGDgh3qrUdKU0pFN/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: streamSnapshot.data?.docs.length,
              itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(streamSnapshot.data?.docs[index]['text']),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/0zf2EGDgh3qrUdKU0pFN/messages')
              .add({
            'text':
                'This was added by clicking the button! ${DateTime.now().toIso8601String()}'
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
