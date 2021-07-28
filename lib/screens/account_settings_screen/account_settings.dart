import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/screens/account_settings_screen/account_text_form.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';

class AccountSettings extends StatefulWidget {
  AccountSettings({required this.userObj});

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    final _backgroundColor = Colors.orangeAccent[100];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: _backgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account Settings',
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
            child: AccountTextForm(),
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
