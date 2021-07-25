import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';

class BuildTextForm extends StatefulWidget {
  BuildTextForm(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.urlAvatar});

  final firstName;
  final lastName;
  final email;
  final urlAvatar;

  @override
  _BuildTextFormState createState() => _BuildTextFormState();
}

class _BuildTextFormState extends State<BuildTextForm> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String firstName = widget.firstName;
    String lastName = widget.lastName;
    String _name = '$firstName $lastName';

    TextEditingController _firstName = TextEditingController(text: firstName);
    TextEditingController _lastName = TextEditingController(text: lastName);
    TextEditingController _email = TextEditingController(text: widget.email);

    final _colorBrown = Colors.brown;
    final _colorBlueAccent = Colors.blueAccent;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 35),
            Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(widget.urlAvatar)),
                  SizedBox(width: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: TextStyle(fontSize: 20, color: _colorBrown),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.email,
                        style: TextStyle(fontSize: 14, color: _colorBrown),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(
                  color: _colorBlueAccent,
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
                  color: _colorBlueAccent,
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
                  color: _colorBlueAccent,
                ),
                labelText: 'Email Address',
                labelStyle: TextStyle(
                  color: _colorBlueAccent,
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
                  color: _colorBlueAccent),
              child: MaterialButton(
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }

                  bool successful = await DBServices().updateUser(
                      _email.text.trim(),
                      _firstName.text.trim(),
                      _lastName.text.trim());

                  if (successful) {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            buildAlertBox(context, '', 'Update Successful'));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => buildAlertBox(
                            context, '', 'Error! Please try again later'));
                  }
                },
                child: Text(
                  'Update Your Info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAlertBox(BuildContext context, String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('OK'),
        ),
      ],
    );
  }
}
