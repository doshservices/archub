import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
            child: Image.asset(
          'assets/icons/lg.png',
          height: 40,
        )),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
          ))
        ],
      ),
      body: Column(children: [
        SizedBox(height: 10),
        ListTile(
          leading: Image.asset(
            'assets/icons/setting.png',
            height: 70,
          ),
          title: Text(
            "Account settings",
            style: TextStyle(color: Color(0xff28384F)),
          ),
        ),
        SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 10),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'Change username',
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //       Icon(Icons.chevron_right)
                        //     ]),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(KResetPasswordScreen);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Change password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(Icons.chevron_right)
                              ]),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return Dialog(
                                    child: Container(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Column(
                                          children: [
                                            Center(
                                                child: Text(
                                              "Confirm you want to logout",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            SizedBox(height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff8C191C)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: RoundedRaisedButton(
                                                      title: 'Logout',
                                                      titleColor: Colors.white,
                                                      buttonColor:
                                                          Color(0xff8C191C),
                                                      onPress: () {
                                                        auth.logout();
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pushNamedAndRemoveUntil(
                                                                kLoginScreen,
                                                                (route) =>
                                                                    false);
                                                      },
                                                    ),
                                                  ),
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Log out',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(Icons.chevron_right)
                              ]),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return Dialog(
                                    child: Container(
                                      height: 230,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Column(
                                          children: [
                                            Center(
                                                child: Text(
                                              "Confirm you want to \ndelete your account?",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            SizedBox(height: 20),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(30)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Why do you want to delete your account?',
                                                    border: InputBorder.none
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff8C191C)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: RoundedRaisedButton(
                                                      title: 'Delete',
                                                      titleColor: Colors.white,
                                                      buttonColor:
                                                          Color(0xff8C191C),
                                                      onPress: () {
                                                        // auth.logout();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delete account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(Icons.chevron_right)
                              ]),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            child: RoundedRaisedButton(
              title: 'Save changes',
              buttonColor: Color(0xff8C191C),
            ),
          ),
        ),
        SizedBox(height: 40),
      ]),
    );
  }
}
