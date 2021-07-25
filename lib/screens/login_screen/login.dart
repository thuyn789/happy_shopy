///This is the login screen of the app
import 'package:flutter/material.dart';
import 'package:happy_shopy/animation/FadeAnimation.dart';
import 'package:happy_shopy/firebase_api/auth_services.dart';
import 'package:happy_shopy/screens/forgot_pass_screen/forgot_password.dart';
import 'package:happy_shopy/streams/init_stream.dart';
import 'package:happy_shopy/screens/signup_screen/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    final _colorBlack = Colors.black;
    final _colorBlueAccent = Colors.blueAccent;
    final _colorWhite = Colors.white;
    final _fontWeight = FontWeight.bold;
    return Scaffold(
      body: Center(
        child: Container(
          width: 500, //for web app screen
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: FadeAnimation(
            1.2,
            Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 55),
                  //Page Title
                  Center(
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 35,
                        color: _colorBlueAccent,
                        fontWeight: _fontWeight,
                      ),
                    ),
                  ),
                  //Subtitle
                  Center(
                    child: Text(
                      'Please login to continue',
                      style: TextStyle(
                        fontSize: 20,
                        color: _colorBlueAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 75),
                  //Text field for email
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'name@email.com',
                      hintStyle: TextStyle(
                        color: _colorBlueAccent,
                      ),
                      labelText: 'Email Address',
                      labelStyle: TextStyle(
                        color: _colorBlueAccent,
                      ),
                      suffixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  //Text field for password
                  TextFormField(
                    obscureText: _hideText,
                    controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: _colorBlueAccent,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hideText = !_hideText;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  //Forgot password button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontWeight: _fontWeight,
                                color: _colorBlueAccent),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  //Login button
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.orangeAccent[100]),
                    child: MaterialButton(
                      //When clicked, the app will contact firebase for authentication
                      //using user's inputted login credential
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {
                          return;
                        }

                        bool successful = await AuthServices()
                            .login(_email.text.trim(), _password.text.trim());
                        if (successful) {
                          //when successful, navigate user to home page
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InitStream()));
                        } else {
                          //when not successful, popup alert
                          //and prompt user to try again
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('Error! Please try again!'),
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
                        'Login',
                        style: TextStyle(fontWeight: _fontWeight),
                      ),
                    ),
                  ),
                  //Create new account button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'New to Happy Shopy?',
                        style: TextStyle(
                            fontWeight: _fontWeight,
                            color: _colorBlueAccent),
                      ),
                      MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            'Create New Account',
                            style: TextStyle(
                                fontWeight: _fontWeight,
                                color: _colorBlueAccent),
                          )),
                    ],
                  ),
                  SizedBox(height: 35),
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: _colorBlack,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    )),
                    Text("OR"),
                    Expanded(
                        child: Divider(
                      color: _colorBlack,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    )),
                  ]),
                  SizedBox(height: 35),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.red),
                    child: MaterialButton(
                      //When clicked, the app will contact firebase for authentication
                      //using user's inputted login credential
                      onPressed: () async {
                        await AuthServices().signInWithGoogle();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitStream()));
                      },
                      child: Text(
                        'Login with Google',
                        style: TextStyle(
                            fontWeight: _fontWeight, color: _colorWhite),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  //Anonymous sign-in
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: _colorBlueAccent),
                    child: MaterialButton(
                      //When clicked, the app will contact firebase for authentication
                      //using user's inputted login credential
                      onPressed: () async {
                        await AuthServices().signInAnon();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitStream()));
                      },
                      child: Text(
                        'Login As a Guest',
                        style: TextStyle(
                            fontWeight: _fontWeight, color: _colorWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
