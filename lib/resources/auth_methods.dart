import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    String message = 'Some error bumped';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        //! AUTH
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //! FIRESTORE
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          "uid": userCredential.user?.uid,
          "email": email,
          "username": username,
          "bio": bio,
          "followers": [],
          "following": [],
        });

        message = 'Success';
      }
    } catch (error) {
      message = error.toString();
    }
    print(message);
    return message;
  }
}
