import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';
import 'package:happy_shopy/streams/order_info_stream.dart';
import 'package:happy_shopy/streams/order_items_stream.dart';

class OrderConfirmation extends StatefulWidget {
  OrderConfirmation({required this.userObj, required this.orderNumber});

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;
  final String orderNumber;

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    final _backgroundColor = Colors.orangeAccent[100];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: _backgroundColor,
        title: Text(
          'Order Details',
          style: TextStyle(
            fontSize: 25,
            color: _color,
            fontWeight: FontWeight.bold,
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
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: OrderItemStream(orderNumber: widget.orderNumber, userObj: widget.userObj,),
                  ),
                ),
                OrderInfoStream(orderNumber: widget.orderNumber),
              ],
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
