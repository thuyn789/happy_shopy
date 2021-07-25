import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/auth_services.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _color = Colors.blueAccent;
    final _fontWeight = FontWeight.bold;
    return Scaffold(
      body: Center(
        child: Container(
          width: 500, //for web app screen
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 35,
                      color: _color,
                      fontWeight: _fontWeight,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Please enter your email',
                    style: TextStyle(
                      fontSize: 20,
                      color: _color,
                    ),
                  ),
                ),
                SizedBox(height: 75),
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
                      //Uncomment this line to connect to Firebase Auth
                      //bool successful = await AuthServices().resetPassword(_email.text);

                      //Proof of concept
                      bool successful = true;

                      if (successful) {
                        //when successful, navigate user to login page
                        String _emailCheck = _email.text;

                        showDialog(
                            context: context,
                            builder: (context) => buildAlertBox(context, '',
                                'Reset email has been sent to $_emailCheck',true));
                      } else {
                        //when not successful, popup alert
                        //and prompt user to try again

                        showDialog(
                            context: context,
                            builder: (context) => buildAlertBox(context, '',
                                'Error! Please try again!', false));
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: _fontWeight, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Got your password?',
                      style: TextStyle(
                          fontWeight: _fontWeight,
                          color: _color),
                    ),
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          'Login here',
                          style: TextStyle(
                              fontWeight: _fontWeight,
                              color: _color),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAlertBox(
      BuildContext context, String title, String content, bool secondPop) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            if (secondPop) {
              Navigator.pop(context, true);
            }
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
