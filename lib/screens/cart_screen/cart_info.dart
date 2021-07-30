import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/payment_api/stripe_payment_services.dart';
import 'package:happy_shopy/screens/order_confirmation_screen/order_confirmation.dart';

class CartInfo extends StatelessWidget {
  CartInfo({required this.dataObj, required this.userObj});

  final dataObj;

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

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

    final _cartInfo = ({
      'itemCount': itemCount,
      'subtotal': subtotal,
      'shipping': shipping,
      'tax': tax,
      'taxRate': taxRate,
      'total': total,
    });

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
                        itemCount < 2
                            ? Text('$itemCount item', style: textStyle)
                            : Text('$itemCount items', style: textStyle),
                      ],
                    ),
                    Row(
                      children: [
                        Text('(Maximum 15 items)', style: textStyle),
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
                        Text(
                          'Subtotal:',
                          style: textStyle,
                        ),
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
          payButton(context, total, _cartInfo),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget payButton(BuildContext context, double total, final cartInfo) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.blueAccent),
      child: MaterialButton(
        onPressed: () async {
          if (total <= 0) {
            buildSnackBar(context, 'Please add something to cart');
            return;
          }
          var _paymentInfo;
          var _cardInfo;

          //Initialize Stripe services with Publishable key and Secret key
          StripeServices().initializeStripePayment();

          bool _successful = await StripePayment.paymentRequestWithCardForm(
                  CardFormPaymentRequest())
              .then((paymentMethod) {
            _paymentInfo = paymentMethod.toJson();
            _cardInfo = _paymentInfo['card'];
            return true;
          }).catchError(((error, stackTrace) {
            return false;
          }));

          if (_successful) {
            String orderNumber = '${_paymentInfo['created']}';
            buildSnackBar(context, 'Payment Charged Successful');

            await DBServices()
                .paymentConfirm(_paymentInfo, _cardInfo, cartInfo);

            //Wait before go to order confirmation
            await Future.delayed(const Duration(seconds: 1));

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderConfirmation(
                          userObj: userObj,
                          orderNumber: orderNumber,
                        )));
          } else {
            buildSnackBar(context, 'Payment Failed! Please try again!');
          }
        },
        child: Text(
          'Proceed to Pay',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
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
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 35, horizontal: 50),
      shape: StadiumBorder(),
      backgroundColor: Colors.grey[600],
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
