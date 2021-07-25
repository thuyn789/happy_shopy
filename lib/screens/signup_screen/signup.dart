import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/auth_services.dart';
import 'package:happy_shopy/streams/init_stream.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordAgain = TextEditingController();

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
                    'Create New Account',
                    style: TextStyle(
                      fontSize: 35,
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
                SizedBox(height: 75),
                TextFormField(
                  controller: _firstName,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      color: _color,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _lastName,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      color: _color,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 5),
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
                    }),
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

                      bool successful = await AuthServices().signUp(
                        _firstName.text.trim(),
                        _lastName.text.trim(),
                        _email.text.trim(),
                        _password.text.trim(),
                      );
                      if (successful) {
                        //when successful, navigate user to home page
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitStream(widgetSwitch: 0,)));
                      } else {
                        //when not successful, popup alert
                        //and prompt user to try again
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('Error! Please try again later'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                          fontWeight: _fontWeight, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
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
}
