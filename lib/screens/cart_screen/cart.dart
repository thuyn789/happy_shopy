import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        actions: [
          TextButton.icon(
            onPressed: () async {await DBServices().emptyCart();},
            icon: Icon(
              Icons.remove_shopping_cart,
              color: _color,
            ),
            label: Text(
              'Empty Cart',
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
                Divider(
                  color: Colors.brown,
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                CartInfoStream(),
                Divider(
                  color: Colors.brown,
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                SizedBox(height: 25),
                checkoutButton(context),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget checkoutButton(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.blueAccent),
      child: MaterialButton(
        onPressed: () {
          print('Checkout');
          //await DBServices().emptyCart();
        },
        child: Text(
          'Proceed to Checkout',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white),
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
