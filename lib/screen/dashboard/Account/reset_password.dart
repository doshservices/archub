import 'package:archub/constants.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isLoading = false;
  GlobalKey<FormState> _updateFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController _passwordController = TextEditingController();
  String oldpassword, newPassword;

  Future<void> resetPassword() async {
    if (!_updateFormKey.currentState.validate()) {
      return;
    }

    _updateFormKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .resetPassword(oldpassword, newPassword);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            final auth = Provider.of<Auth>(context, listen: true);
            return AlertDialog(
              title: Text(
                "Success",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text("Your Password has been successfully updated."),
              actions: [
                FlatButton(
                  child: Text("OK", style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                    auth.logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        kLoginScreen, (route) => false);
                  },
                ),
              ],
            );
          });
    } catch (error) {
      // final auth = Provider.of<Auth>(context, listen: false);
      // if (error.toString() == "401") {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   auth.logout();
      //   Navigator.of(context)
      //       .pushNamedAndRemoveUntil(KWalkThrough, (route) => false);
      // } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                "Error",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text("$error"),
              actions: [
                FlatButton(
                  child: Text("OK", style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      // }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.keyboard_arrow_left,
                size: 30,
              )),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Color(0xffF2F6FA),
          elevation: 0,
          title: Center(
              child: Text(
            "Change Password",
            style: TextStyle(fontSize: 22, color: Colors.black),
          ))),
      body: Container(
          color: Color(0xffF2F6FA),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Form(
                key: _updateFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      DistributorTextFormField(
                        // withoutlabel: true,
                        // textcolor: Colors.black,
                        labelText: 'Old Password',
                        // controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password can't be empty";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          oldpassword = value;
                        },
                      ),
                      SizedBox(height: 20),
                      DistributorTextFormField(
                        labelText: 'New Password',
                        validator: (value) {
                          String pattern = r'^(?=.*?[a-z])';
                          String pattern2 = r'^(?=.*?[0-9])';
                          RegExp regExp = new RegExp(pattern);
                          RegExp regExp2 = new RegExp(pattern2);
                          if (value.isEmpty) {
                            return "Password can't be empty";
                          }
                          if (value.length < 7) {
                            return "Password must be between 7 to 30 characters";
                          }
                          if (regExp.hasMatch(value).toString() != "true") {
                            print(regExp.hasMatch(value));
                            return "Password must have at least one lowercase character !!";
                          }
                          if (regExp2.hasMatch(value).toString() != "true") {
                            print(regExp.hasMatch(value));
                            return "Password must have at least one digit character !!";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          newPassword = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: RoundedRaisedButton(
                    title: _isLoading ? "Processing..." : 'Reset',
                    isLoading: _isLoading,
                    onPress: () {
                      resetPassword();
                    },
                    buttonColor: kAccentColor,
                    titleColor: Colors.white,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
