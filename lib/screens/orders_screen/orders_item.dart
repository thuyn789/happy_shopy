import 'package:flutter/material.dart';
import 'package:happy_shopy/screens/order_confirmation_screen/order_confirmation.dart';

class OrdersItem extends StatelessWidget {
  OrdersItem({required this.dataObj, required this.userObj});

  final dataObj;
  final userObj;

  @override
  Widget build(BuildContext context) {
    final String orderNumber = dataObj['order_number'];
    final String imageURL =
        'https://firebasestorage.googleapis.com/v0/b/supercool-rental.appspot.com/o/order_delivery_icon.png?alt=media&token=167c000a-08ed-4ff0-b986-2189d6e4fffc';

    return SafeArea(
      child: Card(
        color: Colors.grey[200],
        child: ListTile(
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(imageURL),
            //backgroundImage: ,
          ),
          title: Text('Order#: $orderNumber',),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmation(
                    userObj: userObj,
                    orderNumber: orderNumber,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
