import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>> firestoreStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.messenger_outline))],
      ),
      // body: SingleChildScrollView(child: Column(children: List.generate(5, (i) => PostCard()))),
      body: StreamBuilder(
        stream: firestoreStream,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snap.data!.docs.length,
            itemBuilder: (ctx, i) {
              return PostCard(snap: snap.data!.docs[i]);
            },
          );
        },
      ),
    );
  }
}
