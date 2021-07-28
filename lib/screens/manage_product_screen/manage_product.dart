import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/streams/product_stream.dart';

class ManageProduct extends StatefulWidget {
  ManageProduct({
    required this.userObj,
  });

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    final _fontWeight = FontWeight.bold;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: Colors.orangeAccent[100],
        title: Text(
          'Manage Product',
          style: TextStyle(
            fontSize: 25,
            color: _color,
            fontWeight: _fontWeight,
          ),
        ),
      ),
      drawer: NavigationDrawer(
        userObj: widget.userObj,
      ),
      body: Center(
        child: FadeAnimation(
          2.3,
          Container(
            width: 500, //for web app screen
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: ProductStream(
              widgetSwitch: 1,
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
