import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/home_screen/build_card_item.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';

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
  //This variable is to control the appearance of the "Add Message" button

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
            onPressed: () {
              print('cart');
              /*
              showDialog(
                  context: context,
                  builder: (context) => buildSignOutAlert(
                      context, 'Signing Out?', 'Do you want to sign out?'));
               */
            },
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
      body: FadeAnimation(
        2.3,
        Center(
          child: Container(
            width: 500, //for web app screen
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: StreamBuilder<QuerySnapshot>(
                stream: DBServices().productStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading"));
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      final data = document.data() as Map<String, dynamic>;
                      return BuildCardItem(
                          itemName: data['name'],
                          brand: data['brand'],
                          price: data['price'],
                          imageURL: data['imageURL']);
                        /*
                        cardTemplate(
                        data['name'],
                        data['brand'],
                        data['price'],
                        data['imageURL'],
                      );*/
                    }).toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
