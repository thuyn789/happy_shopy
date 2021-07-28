import 'package:flutter/material.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/screens/add_product_screen/product_text_form.dart';

class AddProduct extends StatefulWidget {
  AddProduct({required this.userObj});

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    final _backgroundColor = Colors.orangeAccent[100];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: _backgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Product',
              style: TextStyle(
                fontSize: 25,
                color: _color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(
        userObj: widget.userObj,
      ),
      body: Center(
        child: Container(
          width: 500,
          child: ProductTextForm(),
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
