import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';

class CartInfoStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DBServices().cartInfoStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Text("Loading"));
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData) {
                final dataObj = snapshot.data!.data() as Map<dynamic, dynamic>;
                return cartInfoWidget(dataObj);
              } else {
                return Center(child: Text('Something went wrong'));
              }
          }
        });
  }

  Widget cartInfoWidget(final dataObj) {
    final textStyle = TextStyle(
      fontSize: 17,
      color: Colors.black,
    );
    final taxRate = 0.08;

    double subtotal = dataObj['cartSubtotal'];
    int itemCount = dataObj['cartCount'];
    double shipping = 0.0;
    double tax = subtotal * taxRate;
    double total = subtotal + tax + shipping;

    subtotal = double.parse(subtotal.toStringAsFixed(2));
    shipping = double.parse(shipping.toStringAsFixed(2));
    tax = double.parse(tax.toStringAsFixed(2));
    total = double.parse(total.toStringAsFixed(2));

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Total:    ', style: textStyle),
                    itemCount < 2 ?
                    Text('$itemCount item', style: textStyle) :
                    Text('$itemCount items', style: textStyle),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal:', style: textStyle,),
                    Text('\$$subtotal', style: textStyle),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax 8%:', style: textStyle),
                    Text('\$$tax', style: textStyle),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping:', style: textStyle),
                    Text('\$$shipping', style: textStyle),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:', style: textStyle),
                    Text('\$$total', style: textStyle),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
