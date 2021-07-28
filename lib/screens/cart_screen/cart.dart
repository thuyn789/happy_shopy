import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/streams/cart_stream.dart';

class Cart extends StatefulWidget {
  Cart({
    required this.userObj,
  });

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    final _fontWeight = FontWeight.bold;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: Colors.orangeAccent[100],
        title: Text(
          'Cart',
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
      body: FadeAnimation(
        2.3,
        Center(
          child: Container(
            width: 500, //for web app screen
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: CartStream(),
          ),
        ),
      ),
    );
  }
}
