import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';

class OrderItem extends StatelessWidget {
  OrderItem({required this.dataObj, required this.userObj});

  final dataObj;
  final userObj;

  @override
  Widget build(BuildContext context) {

    final String role = userObj['user_role'];
    final String itemID = dataObj['itemID'];
    final String itemName = dataObj['productName'];
    final double price = dataObj['price'];
    final String imageURL = dataObj['imageURL'];
    final int quantity = dataObj['quantity'];
    final String orderNumber = dataObj['order_number'];
    final String status = dataObj['status'] == null ? '' : dataObj['status'];

    return SafeArea(
      child: Card(
        color: Colors.grey[200],
        child: ListTile(
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(imageURL),
            //backgroundImage: ,
          ),
          title: Text(itemName, ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quantity: $quantity'),
              if(status == 'Canceled')
                Text('($status)'),
              Text('\$$price'),
            ],
          ),

          trailing: role != 'customer' ?
            buildIconButton(context, itemID, orderNumber) : null,
        ),
      ),
    );
  }

  Widget buildIconButton(BuildContext context, String itemID, String orderNumber) {
    return IconButton(
        onPressed: () async {
          bool successful =
          await DBServices().cancelItemFromOrder(itemID, orderNumber, '');

          if(successful){
            buildSnackBar(context, 'Item Canceled');
          }else{
            buildSnackBar(context, 'Error! Please try again!');
          }
        },
        icon: Icon(Icons.cancel),
        tooltip: 'Cancel Item',
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
