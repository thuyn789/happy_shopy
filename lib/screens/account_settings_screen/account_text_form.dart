import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/auth_services.dart';

class AccountTextForm extends StatefulWidget {
  @override
  _AccountTextFormState createState() => _AccountTextFormState();
}

class _AccountTextFormState extends State<AccountTextForm> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _passwordAgain = TextEditingController();

    final _color = Colors.blueAccent;
    final _fontWeight = FontWeight.bold;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 35),
            Center(
              child: Text(
                'Update Login Credential',
                style: TextStyle(
                  fontSize: 30,
                  color: _color,
                  fontWeight: _fontWeight,
                ),
              ),
            ),
            Center(
              child: Text(
                'Please fill out the form',
                style: TextStyle(
                  fontSize: 20,
                  color: _color,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'name@email.com',
                hintStyle: TextStyle(
                  color: _color,
                ),
                labelText: 'Email Address',
                labelStyle: TextStyle(
                  color: _color,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty && value.length <= 8) {
                  return 'Please enter your email';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: _color,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 8) {
                  return 'Password must be 8 characters or more';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              obscureText: true,
              controller: _passwordAgain,
              decoration: InputDecoration(
                labelText: 'Password Again',
                labelStyle: TextStyle(
                  color: _color,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 8) {
                  return 'Password must be 8 characters or more';
                } else if (_password.text != value) {
                  return 'Your password does not match';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 50),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: _color),
              child: MaterialButton(
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }
                  bool successful = await AuthServices().updateLoginCredential(
                      _email.text.trim(), _password.text.trim());

                  if (successful) {
                    buildSnackBar(context, 'Update Successful');
                  } else {
                    buildSnackBar(context, 'Error! Please try again later');
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontWeight: _fontWeight, color: Colors.white),
                ),
              ),
            ),
          ],
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
      duration: Duration(seconds: 3),
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
