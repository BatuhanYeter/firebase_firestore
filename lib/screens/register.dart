import 'package:firebase_auth_trying/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();



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
              label: Text("Sign in"))
        ],
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey, // add the key here, to the form
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
                // if returns null, that means it is solid
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
                validator: (val) => val.length < 8
                    ? 'Password should be at least 8 characters'
                    : null,
                obscureText: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Password Again",
                ),
                controller: passwordAgainController,
                validator: (val) => val != passwordController.text.trim()
                    ? 'Password should match'
                    : null,
                obscureText: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.blue[500],
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    print(emailController.text.trim());
                    print(passwordController.text.trim());
                    dynamic result = await _auth.signUp(context, email: emailController.text.trim(), password: passwordController.text.trim());
                    if(result == null) {
                      // if sth goes wrong, we'll get null and show error
                      // if register is okay, the Stream in auth.dart will
                      // work and show us the home page automatically

                    }
                  }
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
