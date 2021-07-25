///This is the navigatiproviderson drawer of the app
import 'package:flutter/material.dart';
import 'package:happy_shopy/screens/navigation_screen/build_header.dart';
import 'package:happy_shopy/screens/navigation_screen/menu_customer_service.dart';
import 'package:happy_shopy/screens/navigation_screen/menu_user.dart';
import 'package:happy_shopy/screens/navigation_screen/menu_admin.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({
    required this.userObj,
  });

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  Widget build(BuildContext context) {
    String _firstName = userObj['first_name'];
    String _lastName = userObj['last_name'];
    String _name = '$_firstName $_lastName';
    String _email = userObj['email'];
    String _urlAvatar = userObj['urlAvatar'];
    String _userRole = userObj['user_role'];

    bool _isAdmin = false;
    bool _isCS = false;

    //Controller switch for admin and customer services accounts
    _userRole == 'admin' ? _isAdmin = true : _isAdmin = false;
    _userRole == 'support' ? _isCS = true : _isCS = false;

    return Drawer(
      child: Material(
        color: Colors.orangeAccent[100],
        child: ListView(
          children: <Widget>[
            BuildHeader(
              urlAvatar: _urlAvatar,
              name: _name,
              email: _email,
              userObj: userObj,
            ),
            MenuUser(
              userObj: userObj,
            ),
            if (_isAdmin)
              MenuAdmin(
                userObj: userObj,
              ),
            if (_isCS)
              MenuCustomerService(
                userObj: userObj,
              ),
          ],
        ),
      ),
    );
  }
}
