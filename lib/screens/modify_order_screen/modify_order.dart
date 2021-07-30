import 'package:flutter/material.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/screens/order_confirmation_screen/order_confirmation.dart';

class ModifyOrder extends StatefulWidget {
  ModifyOrder({required this.userObj});

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _ModifyOrderState createState() => _ModifyOrderState();
}

class _ModifyOrderState extends State<ModifyOrder> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _orderNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _colorBrown = Colors.brown;
    final _colorBlue = Colors.blueAccent;
    final _fontWeight = FontWeight.bold;
    final _backgroundColor = Colors.orangeAccent[100];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _colorBrown),
        backgroundColor: _backgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Modify Order',
              style: TextStyle(
                fontSize: 25,
                color: _colorBrown,
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
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 35),
                  Center(
                    child: Text(
                      'Order Lookup (Beta)',
                      style: TextStyle(
                        fontSize: 30,
                        color: _colorBlue,
                        fontWeight: _fontWeight,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Please enter order number',
                      style: TextStyle(
                        fontSize: 20,
                        color: _colorBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _orderNumber,
                    decoration: InputDecoration(
                      labelText: 'Order Number',
                      labelStyle: TextStyle(
                        color: _colorBlue,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter order number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 25),
                  Text('Admin test order number: 1627598652, 1627599141, 1627602306, 1627679815'),
                  SizedBox(height: 50),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0), color: _colorBlue),
                    child: MaterialButton(
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {
                          return;
                        }
                        String orderNumber = _orderNumber.text.trim();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderConfirmation(
                                userObj: widget.userObj,
                                orderNumber: orderNumber
                              ),
                            ));
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
