import 'package:flutter/material.dart';
import 'package:happy_shopy/screens/navigation_screen/menu_action.dart';

class MenuUser extends StatelessWidget {
  MenuUser({required this.userObj});

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.message, color: _color),
            title: Text('Home', style: TextStyle(color: _color)),
            onTap: () => MenuAction().menuAction(context, 0, userObj),
          ),
          ListTile(
            leading: Icon(Icons.message, color: _color),
            title: Text('Your Orders', style: TextStyle(color: _color)),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.person_pin_rounded, color: _color),
            title: Text('User Profile', style: TextStyle(color: _color)),
            onTap: () => MenuAction().menuAction(context, 1, userObj),
          ),
          ListTile(
            leading: Icon(Icons.account_box, color: _color),
            title: Text('Account Settings', style: TextStyle(color: _color)),
            onTap: () => MenuAction().menuAction(context, 2, userObj),
          ),
          ListTile(
            leading: Icon(Icons.person, color: _color),
            title: Text('Sign Out?', style: TextStyle(color: _color)),
            onTap: () => MenuAction().menuAction(context, 3, userObj),
          ),
        ],
      ),
    );
  }
}
