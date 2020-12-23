import 'package:firebase_auth_trying/models/user.dart';
import 'package:firebase_auth_trying/services/database.dart';
import 'package:firebase_auth_trying/widgets/exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentEmail;
  String _currentPassword;

  @override
  Widget build(BuildContext context) {
    // This is us accessing the user data from the Provider
    final user = Provider.of<AnonUser>(context);

    return StreamBuilder<SingleUserData>(
        stream: DatabaseService(uid: user.uid).singleUserData,
        // this snapshot is not the snapshot from the whenever we get data
        // from the stream, this snapshot refers to it
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SingleUserData data = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update your user settings.",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: data.name,
                    decoration: InputDecoration(
                        fillColor: Colors.white, labelText: "Name"),
                    validator: (val) =>
                        val.isEmpty ? "Please enter a name" : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: data.email,
                    decoration: InputDecoration(
                        fillColor: Colors.white, labelText: "Email"),
                    validator: (val) =>
                        val.isEmpty ? "Please enter an email" : null,
                    onChanged: (val) => setState(() => _currentEmail = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: data.password,
                    decoration: InputDecoration(
                        fillColor: Colors.white, labelText: "Password"),
                    validator: (val) =>
                        val.isEmpty ? "Please enter a password" : null,
                    onChanged: (val) => setState(() => _currentPassword = val),
                  ),
                  RaisedButton(
                      child: Text("Update"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? data.name,
                              _currentEmail ?? data.email,
                              _currentPassword ?? data.password);
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
            //return showException(context);
          }
        });
  }
}
