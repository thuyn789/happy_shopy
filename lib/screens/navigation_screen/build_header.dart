import 'package:flutter/material.dart';
import 'package:happy_shopy/screens/navigation_screen/menu_action.dart';

class BuildHeader extends StatelessWidget {
  BuildHeader(
      {required this.urlAvatar,
      required this.name,
      required this.email,
      required this.userObj});

  final String urlAvatar;
  final String name;
  final String email;
  final userObj;

  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    return InkWell(
      onTap: () => MenuAction().menuAction(context, 1, userObj),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlAvatar)),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: _color),
                ),
                SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: _color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
