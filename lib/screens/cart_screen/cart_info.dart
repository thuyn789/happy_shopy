import 'package:flutter/material.dart';

class CartInfo extends StatelessWidget {
  CartInfo({required this.dataObj});

  final dataObj;

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          Divider(
            color: Colors.brown,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
          Row(
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
          Divider(
            color: Colors.brown,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
          SizedBox(height: 25),
          checkoutButton(context),
          SizedBox(height: 25),
        ],
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
}
