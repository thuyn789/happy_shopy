import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/streams/cart_info_stream.dart';
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
        actions: [emptyCartButton()],
      ),
      drawer: NavigationDrawer(
        userObj: widget.userObj,
      ),
      body: Center(
        child: FadeAnimation(
          2.3,
          Container(
            width: 500, //for web app screen
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: CartStream(),
                  ),
                ),
                CartInfoStream(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emptyCartButton() {
    return TextButton.icon(
      onPressed: () async {await DBServices().emptyCart();},
      icon: Icon(
        Icons.remove_shopping_cart,
        color: Colors.brown,
      ),
      label: Text(
        'Empty Cart',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
      ),
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
