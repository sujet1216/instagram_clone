import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/logger.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Uint8List? pickedImage;

  bool isLoading = false;
  bool isLogin = true;

  void pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: source);

    if (xFile != null) {
      Uint8List img = await xFile.readAsBytes();
      setState(() {
        pickedImage = img;
      });
    }
  }

  void authenticateUser() async {
    if (!isLogin) {
      //! .signUpUser()
      setState(() => isLoading = true);
      var res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passController.text,
        bio: _bioController.text,
        username: _usernameController.text,
        file: pickedImage,
      );
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(res)));
      }
    } else {
      //! .signInUser()
      setState(() => isLoading = true);

      String res = await AuthMethods().signInUser(
        email: _emailController.text,
        password: _passController.text,
      );
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _passController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isLogin)
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        pickedImage != null
                            ? MemoryImage(pickedImage!)
                            : NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
                            ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      onPressed: () => pickImage(ImageSource.gallery),
                      icon: Icon(Icons.add_a_photo, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              controller: _passController,
            ),
            if (!isLogin)
              Column(
                children: [
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(),
                    ),
                    controller: _bioController,
                  ),
                ],
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : authenticateUser,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
