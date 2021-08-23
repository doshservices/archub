import 'package:archub/model/user.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SignUpScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _regFormKey = GlobalKey();
  GlobalKey<FormState> _tokeFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true, _hidePassword1 = true;
  bool _isLoading = false;
  String token = "";
  User user = User();

  Future<void> signup(BuildContext context) async {
    if (!_regFormKey.currentState.validate()) {
      return;
    }
    if (!_tokeFormKey.currentState.validate()) {
      return;
    }
    _regFormKey.currentState.save();
    _tokeFormKey.currentState.save();

    // setState(() {
    //   _isLoading = true;
    // });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
      _isLoading = true;
      // errMsg = "";
    });
    try {
      await Provider.of<Auth>(context, listen: false).signUp(user, token);
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                "Success",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                  "Your account has been successfully created. Kindly check your email to verify Account"),
              actions: [
                FlatButton(
                  child: Text("Proceed to Login",
                      style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed(kLoginScreen);
                  },
                ),
              ],
            );
          });
    } catch (error) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                "Error",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text("${error.toString()}"),
              actions: [
                FlatButton(
                  child: Text("OK", style: TextStyle(color: Colors.white)),
                  color: Color(0xff24414D),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }else{
      print('Not connected');
      _showShackBar('Please check your Internet connection!!!');
        setState(() {
          // errMsg = "Invalid credential";
          _isLoading = false;
      });
    }
    
  }

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: Text(
        errorMessage.toString(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[400],
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<void> getToken(BuildContext context) async {
    if (!_regFormKey.currentState.validate()) {
      return;
    }
    _regFormKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
      _isLoading = true;
      // errMsg = "";
    });
    try {
      await Provider.of<Auth>(context, listen: false).getOtp(user);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (error) {
      _showShackBar(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }else{
    print('Not connected');
      _showShackBar('Please check your Internet connection!!!');
        setState(() {
          // errMsg = "Invalid credential";
          _isLoading = false;
      });
  }
    
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/log2.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ))
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login',
                          style:
                              TextStyle(color: Color(0xffC4C4C4), fontSize: 24),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(KSignUpScreen);
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              TextStyle(color: Color(0xff8C191C), fontSize: 24),
                        ),
                      )),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  height: height,
                  width: width,
                  child: Theme(
                    data: ThemeData(primaryColor: Colors.black),
                    child: Column(children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _regFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
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
                                  user.fullName = value;
                                },
                              ),
                              Container(height: 1, color: Colors.black),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Your Email",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffC3BBBB),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "required";
                                  } else if (!value.contains("@") ||
                                      !value.contains(".")) {
                                    return "Enter a valid email address";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  user.email = value;
                                },
                              ),
                              Container(height: 1, color: Colors.black),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffC3BBBB),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: _hidePassword
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Color(0xff24414D),
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: Color(0xff24414D),
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  user.password = value;
                                },
                                obscureText: _hidePassword,
                              ),
                              Container(height: 1, color: Colors.black),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffC3BBBB),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: _hidePassword1
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Color(0xff24414D),
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: Color(0xff24414D),
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword1 = !_hidePassword1;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _hidePassword1,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                              ),
                              Container(height: 1, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Form(
                                key: _tokeFormKey,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
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
                                    token = value;
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  getToken(context);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('Send a Token'),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(height: 1, color: Colors.black),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 55,
              width: double.infinity,
              child: RoundedRaisedButton(
                title: "Sign up",
                isLoading: _isLoading,
                titleColor: Colors.white,
                buttonColor: Color(0xff8C191C),
                onPress: () {
                  signup(context);
                },
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
