import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:uuid/uuid.dart';

class AddPostMethod {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPost({
    required String description,
    required String username,
    required String profImage,
    required String uid,
    required Uint8List postFile,
  }) async {
    var postId = Uuid().v4();

    String downloadUrl = await storage
        .ref('posts/$uid/$postId')
        .putData(postFile)
        .then((snap) => snap.ref.getDownloadURL());

    Post post = Post(
      description: description,
      uid: uid,
      username: username,
      likes: [],
      postId: postId,
      datePublished: DateTime.now(),
      postUrl: downloadUrl,
      profImage: profImage,
    );

    return await firestore.collection('posts').doc(postId).set(post.toJson());
  }
}
