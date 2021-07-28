import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/screens/navigation_screen/menu_action.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/streams/product_stream.dart';

class HomePage extends StatefulWidget {
  HomePage({
    required this.userObj,
  });

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    final _fontWeight = FontWeight.bold;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: Colors.orangeAccent[100],
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 25,
            color: _color,
            fontWeight: _fontWeight,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => MenuAction().menuAction(context, 6, widget.userObj),
            icon: Icon(
              Icons.shopping_cart,
              color: _color,
            ),
            label: Text(
              'Cart',
              style: TextStyle(fontWeight: FontWeight.bold, color: _color),
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          )
        ],
      ),
      drawer: NavigationDrawer(
        userObj: widget.userObj,
      ),
      body: Center(
        child: FadeAnimation(
          2.3,
          Container(
            width: 500, //for web app screen
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: ProductStream(widgetSwitch: 0,),
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
