import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  const UserModel({
    required this.bio,
    required this.email,
    required this.followers,
    required this.following,
    required this.photoUrl,
    required this.uid,
    required this.username,
  });

  final String uid;
  final String email;
  final String username;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "username": username,
      "bio": bio,
      "photoUrl": photoUrl,
      "followers": followers,
      "following": following,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      bio: snapshot['bio'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
      username: snapshot['username'],
    );
  }
}
