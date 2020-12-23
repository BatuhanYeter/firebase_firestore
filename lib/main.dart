import 'package:firebase_auth_trying/models/user.dart';
import 'package:firebase_auth_trying/screens/wrapper.dart';
import 'package:firebase_auth_trying/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChangeViewProvider(),
        ),
        StreamProvider<AnonUser>.value(
          value: AuthService().user,
        ),
        StreamProvider(
          create: (context) => DatabaseService().userData,
          lazy: false,
        ),
      ],
      child: MaterialApp(
        // and it's wrapping this MaterialApp
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
