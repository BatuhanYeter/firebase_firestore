import 'package:firebase_auth_trying/home/user_tile.dart';
import 'package:firebase_auth_trying/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  @override
  Widget build(BuildContext context) {

    List<UserData> users = Provider.of<List<UserData>>(context);

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(user: users[index]);
      }, // this is the function itself
    );
  }
}
