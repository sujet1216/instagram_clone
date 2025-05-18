import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/logger.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.snap});

  final QueryDocumentSnapshot<Map<String, dynamic>> snap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    logger.w(widget.snap.data());
    Map<String, dynamic> post = widget.snap.data();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(radius: 16, backgroundImage: NetworkImage(post['profImage'])),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(post['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {},
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(post['postUrl'], fit: BoxFit.cover),
                ),
                Icon(Icons.favorite, color: Colors.white, size: 100),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite, color: Colors.red)),
              IconButton(icon: const Icon(Icons.comment_outlined), onPressed: () {}),
              IconButton(icon: const Icon(Icons.send), onPressed: () {}),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    "${(post['likes'] as List).length.toString()} likes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: '${post['username']} ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: post['description']),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('View all  comments', style: const TextStyle(fontSize: 16)),
                  ),
                  onTap: () {},
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text((post['datePublished'] as Timestamp).toDate().toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
