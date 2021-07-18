import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SignUpScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          height: height,
          width: width,
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Color(0xff28384F), fontSize: 24),
                  )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffC3BBBB),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _userEmail = value;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                    decoration: InputDecoration(
                      hintText: "Your Email",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffC3BBBB),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _userPassword = value;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffC3BBBB),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _userPassword = value;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                    decoration: InputDecoration(
                      hintText: "Repeat Password",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffC3BBBB),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _userPassword = value;
                    },
                  ),
                ],
              ),
            )),
            Container(
              margin: EdgeInsets.all(10),
              height: 55,
              width: double.infinity,
              child: RoundedRaisedButton(
                // circleborderRadius: 10,
                title: "Sign up",
                // isLoading: _isLoading,
                titleColor: Colors.white,
                buttonColor: Color(0xff8C191C),
                onPress: () {
                  Navigator.of(context).pushNamed(kLoginScreen);
                  // _submitLogin();
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Already have an account? ',
                    textAlign: TextAlign.end,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(kLoginScreen);
                    },
                    child: Text(
                      ' Login',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40)
          ]),
        ),
      ),
    );
  }
}
