import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/cart_screen/cart_item.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';

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
            child: StreamBuilder<QuerySnapshot>(
                stream: DBServices().retrieveCartStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading"));
                  }
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      final data = document.data() as Map<dynamic, dynamic>;
                      return CartItem(
                          itemID: data['itemID'],
                          itemName: data['productName'],
                          price: data['price'],
                          imageURL: data['imageURL']);
                    }).toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
