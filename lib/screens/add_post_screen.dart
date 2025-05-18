import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone/logger.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/add_post_method.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

//! AutomaticKeepAliveClientMixin

class _AddPostScreenState extends State<AddPostScreen> with AutomaticKeepAliveClientMixin {
  TextEditingController descriptionController = TextEditingController();

  Uint8List? file;

  selectImage() async {
    file = await pickImage();
    setState(() {});
  }

  void clearImage() {
    setState(() {
      file = null;
      descriptionController.clear();
    });
  }

  bool isloading = false;

  Future<void> addPost({
    required String description,
    required String uid,
    required username,
    required String profImage,
  }) async {
    if (file != null && descriptionController.text.isNotEmpty) {
      setState(() {
        isloading = true;
      });
      await AddPostMethod().addPost(
        description: description,
        username: username,
        profImage: profImage,
        uid: uid,
        postFile: file!,
      );
      setState(() {
        isloading = false;
      });
      await Future.delayed(Duration(seconds: 1));
      clearImage();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserModel user = Provider.of<UserProvider>(context).user!;

    return file == null
        ? Center(child: IconButton(onPressed: selectImage, icon: Icon(Icons.upload)))
        : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: Text('Post to'),
            centerTitle: false,
            leading: IconButton(onPressed: clearImage, icon: Icon(Icons.arrow_back)),
            actions: [
              TextButton(
                onPressed:
                    () => addPost(
                      description: descriptionController.text,
                      uid: user.uid,
                      username: user.username,
                      profImage: user.photoUrl,
                    ),
                child: Text('Post', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          body: Column(
            children: [
              isloading ? LinearProgressIndicator() : SizedBox.shrink(),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(user.photoUrl)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          label: Text('Write caption...'),
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(image: DecorationImage(image: MemoryImage(file!))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}
