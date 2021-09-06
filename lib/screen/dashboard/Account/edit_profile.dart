import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _editFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _isLoading = false;
  String fullName, city, country, location, phoneNumber;
  // int phoneNumber;

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

  Future<void> _submitLogin() async {
    if (!_editFormKey.currentState.validate()) {
      return;
    }
    _editFormKey.currentState.save();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .editProfile(fullName, city, country, phoneNumber, location);
        await Provider.of<Auth>(context, listen: false).getProfile();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(KDashboard, (route) => false);
      } catch (error) {
        if (error.toString().isNotEmpty) {
          _showShackBar(error.toString());
          setState(() {
            // errMsg = error.toString();
          });
        } else {
          _showShackBar('Invalid credential');
          setState(() {
            // errMsg = "Invalid credential";
            _isLoading = false;
          });
        }
      } finally {
        setState(() {
          // errMsg = "";
          _isLoading = false;
        });
      }
    } else {
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
    final user = Provider.of<Auth>(context).user;
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Center(
                            child: Stack(children: [
                              ClipOval(
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[100],
                                    child:
                                        // _image != null
                                        //     ? Image.file(
                                        //         _image,
                                        //         fit: BoxFit.fill,
                                        //       )
                                        //     : CircleAvatar(
                                        //         radius: 50,
                                        //         backgroundColor: Colors.white,
                                        //         child: user.pictureUrl.toString() !=
                                        //                 null.toString()
                                        //             ?
                                        //             Container(
                                        //                 // height: 75,
                                        //                 child: Image.network(
                                        //                 user.pictureUrl,
                                        //                 height: double.infinity,
                                        //                 width: double.infinity,
                                        //                 fit: BoxFit.fill,
                                        //               ))
                                        //               :
                                        Icon(
                                      Icons.person_outline,
                                      size: 30,
                                    )),
                              ),
                              Positioned(
                                  right: 1,
                                  bottom: 10,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                    color: Colors.grey[600],
                                  ))
                            ]),
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: _editFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: user.fullName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "Umar Aisha",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffC3BBBB),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    fullName = value;
                                  },
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: user.phone.toString(),
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "Phone Number (234)",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffC3BBBB),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    phoneNumber = value;
                                  },
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  // initialValue: '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "City",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffC3BBBB),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    city = value;
                                  },
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  // initialValue: '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "Country",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffC3BBBB),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    country = value;
                                  },
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  // initialValue: '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "Location",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffC3BBBB),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    location = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            child: RoundedRaisedButton(
              isLoading: _isLoading,
              title: 'Save changes',
              buttonColor: Color(0xff8C191C),
              onPress: () {
                _submitLogin();
              },
            ),
          ),
        ),
        SizedBox(height: 30),
      ]),
    );
  }
}
