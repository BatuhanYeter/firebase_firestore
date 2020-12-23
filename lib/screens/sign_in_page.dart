import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_trying/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ChangeViewProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                _auth.signInAnon(context);
              },
              icon: Icon(Icons.account_circle_outlined),
              label: Text("Go Anonymously")),
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
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue[500],
                    onPressed: () async {
                      _auth.signIn(
                        context,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    },
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
              FlatButton(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Forgot Password?', style: TextStyle(color: Color(0xff687dea), fontWeight: FontWeight.w600),),
                ),
                onPressed: () async {
                  _provider.changeView("forgot");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
