import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';

class MangeProductItem extends StatelessWidget {
  MangeProductItem({required this.dataObj});
  
  final dataObj;
  
  @override
  Widget build(BuildContext context) {
    final String itemID = dataObj['id'];
    final String itemName = dataObj['name'];
    final String brand = dataObj['brand'];
    final double price = dataObj['price'];
    final String imageURL = dataObj['imageURL'];
    
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
              Text(brand),
              Text('\$$price'),
            ],
          ),
          trailing: buildIconButton(context, itemID),
        ),
      ),
    );
  }

  Widget buildIconButton(BuildContext context, String itemID) {
    return IconButton(
        onPressed: () async {
          bool successful = await DBServices().deleteProductFromListing(itemID);

          if(successful){
            buildSnackBar(context, 'Item Deleted');
          }else{
            buildSnackBar(context, 'Error! Please try again!');
          }
        },
        icon: Icon(Icons.delete));
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
