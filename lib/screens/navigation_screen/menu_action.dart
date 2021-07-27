import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/auth_services.dart';
import 'package:happy_shopy/screens/account_settings_screen/account_settings.dart';
import 'package:happy_shopy/screens/add_product_screen/add_product.dart';
import 'package:happy_shopy/screens/home_screen/home.dart';
import 'package:happy_shopy/screens/login_screen/login.dart';
import 'package:happy_shopy/screens/manage_product_screen/manage_product.dart';
import 'package:happy_shopy/streams/init_stream.dart';

class MenuAction {
  void menuAction(BuildContext context, int index, final userObj) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userObj: userObj,
              ),
            ));
        break;
      case 1:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InitStream(widgetSwitch: 1,),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountSettings(
                userObj: userObj,
              ),
            ));
        break;
      case 3:
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Signing Out?'),
                content: Text('Do you want to sign out?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      AuthServices().signOut();
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            });
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(
                userObj: userObj,
              ),
            ));
        break;
      case 5:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageProduct(
                userObj: userObj,
              ),
            ));
        break;
    }
  }
}
