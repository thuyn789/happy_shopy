import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';

class ProductTextForm extends StatefulWidget {
  @override
  _ProductTextFormState createState() => _ProductTextFormState();
}

class _ProductTextFormState extends State<ProductTextForm> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController _productName = TextEditingController();
    TextEditingController _imageURL = TextEditingController();
    TextEditingController _brand = TextEditingController();
    TextEditingController _price = TextEditingController();

    final _color = Colors.blueAccent;
    final _fontWeight = FontWeight.bold;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 35),
            Center(
              child: Text(
                'Add New Product',
                style: TextStyle(
                  fontSize: 30,
                  color: _color,
                  fontWeight: _fontWeight,
                ),
              ),
            ),
            Center(
              child: Text(
                'Please fill out the form',
                style: TextStyle(
                  fontSize: 20,
                  color: _color,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _productName,
              decoration: InputDecoration(
                labelText: 'Product Name',
                labelStyle: TextStyle(
                  color: _color,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product name';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _brand,
              decoration: InputDecoration(
                labelText: 'Brand',
                labelStyle: TextStyle(
                  color: _color,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product brand';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _price,
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(
                  color: _color,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product price';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _imageURL,
              decoration: InputDecoration(
                labelText: 'Image URL',
                labelStyle: TextStyle(
                  color: _color,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter image URL';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 50),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0), color: _color),
              child: MaterialButton(
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }
                  double _intPrice = double.parse(_price.text);
                  bool successful = await DBServices().addProduct(
                      _productName.text,
                      _imageURL.text,
                      _brand.text,
                      _intPrice);

                  if (successful) {
                    _productName.clear();
                    _imageURL.clear();
                    _brand.clear();
                    _price.clear();

                    buildSnackBar(context, 'Product Added Successful');
                  } else {
                    buildSnackBar(context, 'Error! Please try again later');
                  }
                },
                child: Text(
                  'Submit',
                  style:
                      TextStyle(fontWeight: _fontWeight, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buildSnackBar(BuildContext context, String text) {
    var snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 35, horizontal: 50),
      shape: StadiumBorder(),
      backgroundColor: Colors.grey[600],
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}