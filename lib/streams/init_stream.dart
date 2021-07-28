import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/home_screen/home.dart';
import 'package:happy_shopy/screens/user_profile_screen/user_profile.dart';

class InitStream extends StatelessWidget {
  InitStream({required this.widgetSwitch});

  final int widgetSwitch;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DBServices().userDataStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData) {
                final userObj = snapshot.data!.data() as Map<String, dynamic>;
                return widgetSwitch == 0
                    ? HomePage(userObj: userObj) : UserProfilePage(userObj: userObj,);
              } else {
                return Center(child: Text('Something went wrong'));
              }
          }
        });
  }
}
