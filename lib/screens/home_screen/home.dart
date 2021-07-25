import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/screens/navigation_screen/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({
    required this.userObj,
  });

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //This variable is to control the appearance of the "Add Message" button

  @override
  Widget build(BuildContext context) {
    final _color = Colors.brown;
    final _fontWeight = FontWeight.bold;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _color),
        backgroundColor: Colors.orangeAccent[100],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Home',
              style: TextStyle(
                fontSize: 30,
                color: _color,
                fontWeight: _fontWeight,
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(
        userObj: widget.userObj,
      ),
      body: FadeAnimation(
        1.0,
        Center(
          child: Container(
            width: 500, //for web app screen
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(height: 30),
                //Page Title
                Text(
                  'Topics',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueAccent,
                    fontWeight: _fontWeight,
                  ),
                ),
                Divider(color: _color),
                SizedBox(height: 20),
                cardTemplate('Animal', 'images/animal.jpg', 0),
                SizedBox(height: 20),
                cardTemplate('Car', 'images/car.jpg', 1),
                SizedBox(height: 20),
                cardTemplate('Gaming', 'images/gaming.jpg', 2),
                SizedBox(height: 20),
                cardTemplate('Meme', 'images/meme.jpg', 3),
                SizedBox(height: 30),
                //Text field for email
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardTemplate(String topic, String imageURL, int actionIndex) {
    return GestureDetector(
      onTap: () => cardAction(actionIndex),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.asset(imageURL),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 10),
                Text(
                  topic,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void cardAction(int index) {
    switch (index) {
      case 0:
        print('Animal');
        /*
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                userObj: widget.userObj,
                topic: 'animal',
              ),
            ));
         */
        break;
      case 1:
        print('Car');
        break;
      case 2:
        print('Gaming');
        break;
      case 3:
        print('Meme');
        break;
    }
  }
}
