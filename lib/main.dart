import 'package:archub/screen/authentication/signup.dart';
import 'package:archub/screen/dashboard/dashboard.dart';
import 'package:archub/splashscreen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'screen/authentication/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        kLoginScreen: (ctx) => LoginScreen(),
        KSignUpScreen: (ctx) => SignUpScreen(),
        KDashboard: (ctx) => Dashboard(),
        // kContactUs: (ctx) => ContactUsScreen(),
      },
    );
  }
}
