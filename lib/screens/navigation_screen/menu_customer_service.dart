import 'package:flutter/material.dart';
import 'package:happy_shopy/screens/navigation_screen/menu_action.dart';

class MenuCustomerService extends StatelessWidget {
  MenuCustomerService({required this.userObj});

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 5),
          Row(children: <Widget>[
            Expanded(
                child: Divider(
              color: _color,
              thickness: 1,
              indent: 5,
              endIndent: 5,
            )),
            Text("Support Menu"),
            Expanded(
                child: Divider(
              color: _color,
              thickness: 1,
              indent: 5,
              endIndent: 5,
            )),
          ]),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.message, color: _color),
            title: Text('Modifying Order', style: TextStyle(color: _color)),
            onTap: () => MenuAction().menuAction(context, 0, userObj),
          ),
        ],
      ),
    );
  }
}
