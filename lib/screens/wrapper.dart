import 'package:firebase_auth_trying/authenticate/authenticate.dart';
import 'package:firebase_auth_trying/models/user.dart';
import 'file:///C:/Users/batuh/AndroidStudioProjects/firebase_auth/lib/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This is us accessing the AnonUser data from the Provider
    final user = Provider.of<AnonUser>(context);


    // TODO: Return either Home or Authentication widget
    if(user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
