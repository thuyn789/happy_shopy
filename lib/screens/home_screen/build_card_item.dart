import 'package:flutter/material.dart';

class BuildCardItem extends StatelessWidget {
  BuildCardItem(
      {required this.itemName,
      required this.brand,
      required this.price,
      required this.imageURL});

  final String itemName;
  final String brand;
  final String price;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    final _colorRed = Colors.red;
    final _colorBrown = Colors.brown;
    final _fontWeight = FontWeight.bold;
    return SafeArea(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.network(imageURL),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      itemName,
                      style: TextStyle(
                        fontSize: 25,
                        color: _colorRed,
                        fontWeight: _fontWeight,
                      ),
                    ),
                    Text(
                      brand,
                      style: TextStyle(
                        fontSize: 15,
                        color: _colorRed,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 25,
                        color: _colorBrown,
                        fontWeight: _fontWeight,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('Added to cart');
                      },
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: _colorBrown,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
