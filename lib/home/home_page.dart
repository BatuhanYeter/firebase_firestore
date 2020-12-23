import 'package:firebase_auth_trying/home/settings_form.dart';
import 'package:firebase_auth_trying/models/user_data.dart';
import 'package:firebase_auth_trying/home/user_list.dart';
import 'package:firebase_auth_trying/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_trying/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<UserData>>.value(
      initialData: [],
      value: DatabaseService().userData,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut(
                      context); // We don't need to set this to a value bcs
                  // we will just wait until this complete (await) and when this
                  // is completed, in our stream, we will get a null value from the
                  // signOut() function of our AuthService and it will update
                  // the user in Wrapper.dart and when that user becomes null, the
                  // if statement will return Authenticate() instead of HomePage()
                },
                icon: Icon(Icons.logout),
                label: Text("Logout")),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text("Settings"),
              onPressed: () => _showSettingsPanel(),
            )
          ], // These actions, widgets, will appear top right of appbar
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            )
          ),
            child: UserList()
        ),
      ),
    );
  }
}
