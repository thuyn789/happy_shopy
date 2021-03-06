import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/screens/user_profile_screen/user_text_form.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({
    required this.userObj,
  });

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: Colors.orangeAccent[100],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'User Profile',
              style: TextStyle(
                fontSize: 25,
                color: _color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(
        userObj: widget.userObj,
      ),
      body: Center(
        child: FadeAnimation(
          1.0,
          Container(
            width: 500,
            child: UserTextForm(
              firstName: widget.userObj['first_name'],
              lastName: widget.userObj['last_name'],
              email: widget.userObj['email'],
              urlAvatar: widget.userObj['urlAvatar'],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
