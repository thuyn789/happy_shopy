import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  OrderInfo({required this.dataObj});

  final dataObj;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 17,
      color: Colors.black,
    );
    String orderNumber = dataObj['order_number'];
    int itemCount = dataObj['item_count'];
    String cardEnding = dataObj['card_last4'];
    String cardExp = 'xx/xx';

    String shipping = '${dataObj['order_shipping']}';
    String subtotal = '${dataObj['order_subtotal']}';
    String tax = '${dataObj['order_tax']}';
    String total = '${dataObj['order_total']}';

    String tokenID = dataObj['tokenID'];

    double refund = 0.0;
    if(dataObj['refund'] > 0){
      refund = dataObj['refund'];
    }
    int cancelItem = dataObj['canceled'];

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
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Order#: ', style: textStyle),
                        Text(orderNumber, style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Card Ending: ', style: textStyle),
                        Text(cardEnding, style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Card Exp: ', style: textStyle),
                        Text(cardExp, style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Total: ', style: textStyle),
                        itemCount < 2
                            ? Text('$itemCount item', style: textStyle)
                            : Text('$itemCount items', style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    if(cancelItem > 0)
                    Row(
                      children: [
                        Text('Canceled: ', style: textStyle),
                        cancelItem < 2
                            ? Text('$cancelItem item', style: textStyle)
                            : Text('$cancelItem items', style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Subtotal: ', style: textStyle,),
                        Text('\$$subtotal', style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Tax 8%: ', style: textStyle),
                        Text('\$$tax', style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Shipping: ', style: textStyle),
                        Text('\$$shipping', style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Total: ', style: textStyle),
                        Text('\$$total', style: textStyle),
                      ],
                    ),
                    SizedBox(height: 5),
                    if(refund > 0)
                    Row(
                      children: [
                        Text('Refund: ', style: textStyle),
                        Text('(\$$refund)', style: textStyle),
                      ],
                    ),
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
          SizedBox(height: 15),
          Row(
            children: [
              Text('TokenID: ', style: textStyle,),
              Text(tokenID, style: textStyle),
            ],
          ),
          SizedBox(height: 15),
        ],
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
