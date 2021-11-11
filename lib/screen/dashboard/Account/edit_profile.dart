import 'dart:convert';
import 'dart:io';

import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _editFormKey = GlobalKey();
  GlobalKey<FormState> _addskillFormKey = GlobalKey();
  GlobalKey<FormState> _addsocialFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _isLoading = false;
  String fullName, city, country, bio, phoneNumber;
  bool _isUploadingProfilePicture = false;
  List<dynamic> skill = [];
  List<dynamic> social = [];
  String skillValue = '', socialvalue = '';
  bool _isUploadingSignature = false;
  bool _isInit = true;
  bool _isLocalProfilePicture = false;
  bool _isLocalSignature = false;

  File _profileImage;
  String _profileImageExtension;
  var base64profileImage;
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
            .editProfile(fullName, city, country, phoneNumber, bio, skill, social);
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

  Future getProfileImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 150,
      maxWidth: 150,

      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _profileImage = File(image.path);
      _profileImageExtension =
          _profileImage.path.toString().split("/").last.split(".").last;
      base64profileImage = base64Encode(_profileImage.readAsBytesSync());
      _isUploadingProfilePicture = true;
      _isLocalProfilePicture = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .uploadimage(base64profileImage);
      await Provider.of<Auth>(context, listen: false).getProfile();
      Get.snackbar('Success!', 'Profile picture updated',
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.green,
          overlayBlur: 0,
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(seconds: 2));
    } catch (error) {
      Get.snackbar('Error!', '${error.toString()}',
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.red,
          overlayBlur: 0,
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(seconds: 2));
    } finally {
      setState(() {
        _isUploadingProfilePicture = false;
      });
    }
  }

  addSkill(String skillValue) {
    if (!_addskillFormKey.currentState.validate()) {
      return;
    }
    _addskillFormKey.currentState.save();
    try {
      // skill.add(skillValue);
      // print(skillValue);
      if (skillValue != "") {
        // skill.add(skillValue);
        // setState((){
        //   skillValue = '';
        // });
      }
    } catch (e) {}
  }

  addSocial(String skillValue) {
    if (!_addsocialFormKey.currentState.validate()) {
      return;
    }
    _addsocialFormKey.currentState.save();
    try {
      // skill.add(skillValue);
      // print(skillValue);
      if (skillValue != "") {
        // skill.add(skillValue);
        // setState((){
        //   skillValue = '';
        // });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    skill = user.skills;
    social = user.socialLinks;
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
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            color: Colors.white,
                            width: double.infinity,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  getProfileImage(ImgSource.Both);
                                },
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.2),
                                          radius: 30,
                                          backgroundImage: _isLocalProfilePicture
                                              ? FileImage(_profileImage)
                                              : NetworkImage(
                                                  "${user.pictureUrl != null ? user.pictureUrl : ''}"),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Tap to change picture",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                    _isUploadingProfilePicture
                                        ? Positioned.fill(
                                            child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator()),
                                          ))
                                        : Text(""),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: _editFormKey,
                            child: Column(
                              children: [
                                // TextFormField(
                                //   initialValue: user.fullName,
                                //   style: TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w400,
                                //       fontStyle: FontStyle.normal),
                                //   decoration: InputDecoration(
                                //     focusColor: Colors.black,
                                //     hintText: "Umar Aisha",
                                //     hintStyle: TextStyle(
                                //       fontSize: 16,
                                //       color: Color(0xffC3BBBB),
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //   ),
                                //   validator: (value) {
                                //     if (value.isEmpty) {
                                //       return "required";
                                //     } else {
                                //       return null;
                                //     }
                                //   },
                                //   onSaved: (value) {
                                //     fullName = value;
                                //   },
                                // ),
                                // SizedBox(height: 10),
                                TextFormField(
                                  initialValue:user.phone!= null ? user.phone.toString() : null,
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
                                  initialValue: user.city != null ? user.city.toString() : null,
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
                                  initialValue: user.country!=null ? user.country.toString():null,
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
                                  initialValue: user.bio != null ? user.bio.toString() : null,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "Bio",
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
                                    bio = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Form(
                                  key: _addskillFormKey,
                                  child: TextFormField(
                                    initialValue: skillValue,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal),
                                    decoration: InputDecoration(
                                      focusColor: Colors.black,
                                      hintText: "Add Skill",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffC3BBBB),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // suffix: ,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      skillValue = value;
                                      // setState(() {
                                      //   skillValue = value;
                                      // });
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addSkill(skillValue);
                                  setState(() {
                                    if (skillValue != '') {
                                      skill.add(skillValue);
                                    }

                                    // skillValue = "";
                                  });
                                },
                                child: Text('+ Add Skill'),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black),
                          SizedBox(height: 10),
                          if(skill.length>0)
                          Container(
                            height: 45,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: skill.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Stack(
                                    children: [
                                      // SizedBox(height: 10),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(skill[index].toString()),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: 0,
                                          child: GestureDetector(
                                              onTap: () {
                                                skill.removeWhere((item) =>
                                                    item == skill[index]);
                                                setState(() {});
                                              },
                                              child: Icon(Icons.cancel))),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Form(
                                  key: _addsocialFormKey,
                                  child: TextFormField(
                                    initialValue: skillValue,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal),
                                    decoration: InputDecoration(
                                      focusColor: Colors.black,
                                      hintText: "Add Social",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffC3BBBB),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // suffix: ,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      socialvalue = value;
                                      // setState(() {
                                      //   skillValue = value;
                                      // });
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addSocial(socialvalue);
                                  setState(() {
                                    if (socialvalue != '') {
                                      social.add(socialvalue);
                                    }

                                    // skillValue = "";
                                  });
                                },
                                child: Text('+ Add Social'),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black),
                          SizedBox(height: 10),
                          if(skill.length>0)
                          Container(
                            height: 45,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: social.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Stack(
                                    children: [
                                      // SizedBox(height: 10),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(social[index].toString()),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: 0,
                                          child: GestureDetector(
                                              onTap: () {
                                                social.removeWhere((item) =>
                                                    item == social[index]);
                                                setState(() {});
                                              },
                                              child: Icon(Icons.cancel))),
                                    ],
                                  ),
                                );
                              },
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
