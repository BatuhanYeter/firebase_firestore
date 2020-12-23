import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_trying/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ChangeViewProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                _provider.changeView("in");
              },
              icon: Icon(Icons.login),
              label: Text("Sign in")),
          FlatButton.icon(
              onPressed: () {
                _provider.changeView("up");
              },
              icon: Icon(Icons.person_add),
              label: Text("Register")),
        ],
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Email",
                ),
                controller: emailController,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.blue[400],
                onPressed: () async {
                  _auth.ForgotPassword(
                    context,
                    email: emailController.text.trim(),
                  );
                },
                child: Text("Send the reset mail", style: TextStyle(color: Colors.white),),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
