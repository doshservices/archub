import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          height: height,
          width: width,
          child: Column(
            children: <Widget>[
              Text('Login'),
              Text('Login'),
              Text('Login'),
            ]
          ),
        ),
      ),
    );
  }
}
