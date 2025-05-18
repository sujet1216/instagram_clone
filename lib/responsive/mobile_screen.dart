import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/logger.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int selectedIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void navigationTapped(int page) {
    setState(() {
      selectedIndex = page;
    });
    pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Mobile'),
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         // FirebaseAuth.instance.signOut();
      //         bool logOut = await showDialog(
      //           //barrierDismissible: true,: mashin bool? sheidzleba null daabrunos,da amaze shemocmebac gvicevs
      //           barrierDismissible: false,
      //           context: context,
      //           builder:
      //               (ctx) => AlertDialog(
      //                 content: Text('are you sure?'),
      //                 actions: [
      //                   TextButton(
      //                     onPressed: () {
      //                       Navigator.of(context).pop(true);
      //                     },
      //                     child: Text('yes'),
      //                   ),
      //                   TextButton(
      //                     onPressed: () {
      //                       Navigator.of(context).pop(false);
      //                     },
      //                     child: Text('no'),
      //                   ),
      //                 ],
      //               ),
      //         );
      //         logger.w('x: $logOut');
      //         if (logOut) {
      //           FirebaseAuth.instance.signOut();
      //         }
      //       },
      //       icon: Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        // onPageChanged: (value) => navigationTapped(value),
        controller: pageController,
        children: [
          FeedScreen(),
          Center(child: Text('search')),
          AddPostScreen(),
          Center(child: Text('favorite')),
          Center(child: Text('person')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => navigationTapped(value),
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.green,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '', backgroundColor: Colors.black),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
