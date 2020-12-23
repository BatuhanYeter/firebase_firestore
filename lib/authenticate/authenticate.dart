import 'package:firebase_auth_trying/screens/forgot_password.dart';
import 'package:firebase_auth_trying/screens/register.dart';
import 'package:firebase_auth_trying/screens/sign_in_page.dart';
import 'package:firebase_auth_trying/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ChangeViewProvider>(context);
    if (_provider.returnView() == "in") {
      return SignInPage();
    } else if (_provider.returnView() == "up") {
      return Register();
    } else if(_provider.returnView() == "forgot") {
      return ForgotPassword();
    }
  }
}
