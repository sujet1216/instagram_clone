import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  AuthMethods authMethods = AuthMethods();

  Future<void> refreshUser() async {
    _user = await authMethods.getUser();
    notifyListeners();
  }
}
