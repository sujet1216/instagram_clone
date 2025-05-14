import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/logger.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

        //! STORAGE

        // Reference ref = _storage.ref().child('profilePics').child(userCredential.user!.uid);
        // UploadTask uploadTask = ref.putData(file);
        // TaskSnapshot snap = await uploadTask;
        // String downloadUrl = await snap.ref.getDownloadURL();

        String downloadUrl = await _storage
            .ref('profilePics/${userCredential.user!.uid}')
            .putData(file)
            .then((snap) => snap.ref.getDownloadURL());

        await userCredential.user!.updatePhotoURL(downloadUrl);

        //! FIRESTORE DATABASE
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          "uid": userCredential.user?.uid,
          "email": email,
          "username": username,
          "bio": bio,
          "photoUrl": downloadUrl,
          "followers": [],
          "following": [],
        });

        message = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      logger.e(err);
      logger.e(err.code);
      if (err.code == 'wrong-password') {
        //! ..................
      }
    } catch (error) {
      message = error.toString();
    }
    logger.w(message);
    return message;
  }

  Future<String> signInUser({required String email, required String password}) async {
    String message = 'Absolutly NOthing';
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (err) {
        if (err.code == 'wrong-password') {
          //! ..................
        }
      } catch (error) {
        String err = error.toString();
        int index = err.indexOf(']');
        logger.e(err.substring(index + 2));
        message = err.substring(index + 2);
        // rethrow; // mashin saidanac idzaxeb iq try catch gchirdeba.
      }
    }
    return message;
  }
}
