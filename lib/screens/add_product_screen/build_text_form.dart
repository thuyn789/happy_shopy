import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';

class BuildTextForm extends StatefulWidget {
  @override
  _BuildTextFormState createState() => _BuildTextFormState();
}

class _BuildTextFormState extends State<BuildTextForm> {
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
                  borderRadius: BorderRadius.circular(25.0),
                  color: _color),
              child: MaterialButton(
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }
                  bool successful = await DBServices().addProduct(
                      _productName.text,
                      _imageURL.text,
                      _brand.text,
                      _price.text);

                  if (successful) {
                    _productName.clear();
                    _imageURL.clear();
                    _brand.clear();
                    _price.clear();
                    showDialog(
                        context: context,
                        builder: (context) =>
                            buildAlertBox(context, '', 'Product Added Successful'));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => buildAlertBox(
                            context, '', 'Error! Please try again later'));
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontWeight: _fontWeight, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAlertBox(BuildContext context, String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('OK'),
        ),
      ],
    );
  }
}
