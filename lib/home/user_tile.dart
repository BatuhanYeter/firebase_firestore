import 'package:flutter/material.dart';
import 'package:firebase_auth_trying/models/user_data.dart';

class UserTile extends StatelessWidget {
  final UserData user;

  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/user.png'),
          ),
          title: Text(user.name),
          subtitle: Text("Email: ${user.email}"),
        ),
      ),
    );
  }
}
