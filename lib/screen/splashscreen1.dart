import 'dart:async';

import 'package:archub/constants.dart';
import 'package:archub/provider/user_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash2Screen extends StatefulWidget {
  // const SplashScreen({ Key? key }) : super(key: key);

  @override
  _Splash2ScreenState createState() => _Splash2ScreenState();
}

class _Splash2ScreenState extends State<Splash2Screen> {
  // @override
  // void initState() async{
  //   getalldata();
  //   super.initState();
  //   startTimer();
  // }

  @override
  void didChangeDependencies() {
    getalldata();
    startTimer();
    super.didChangeDependencies();
  }

  void getalldata() async {
    await Provider.of<UserPost>(context, listen: false).getAllUserPort();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushNamedAndRemoveUntil(KDashboard, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffC4C4C4),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset('assets/icons/logo.png'),
          ),
        ));
  }
}
