import 'dart:convert';
import 'dart:io';

import 'package:archub/provider/job_provider.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class JobApplication extends StatefulWidget {
  JobApplication({Key key}) : super(key: key);

  @override
  _JobApplicationState createState() => _JobApplicationState();
}

class _JobApplicationState extends State<JobApplication> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  File file;

  String status = '';

  String base64Image;

  File _image1;
  bool _isLoading = false;

  String imagevalue;

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 400,
      maxWidth: 300,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _image1 = image;
      print(_image1);
      List<int> imageBytes = _image1.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      imagevalue = base64Image;
      print(base64Image);
    });
  }

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: new Text(
        errorMessage,
        textAlign: TextAlign.center,
      ),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.blueGrey,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> _submitApplication() async {
    final id = ModalRoute.of(context).settings.arguments;
    if (_image1 == null) {
        _showShackBar("Please upload job image");
        throw "error";
      }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<JobProvider>(context, listen: false).applyJob(base64Image, id);
        Get.snackbar('Success!', 'Job applied for successfully',
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.green,
          overlayBlur: 0,
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(seconds: 2));
          Future.delayed(Duration(seconds: 2)).then((value) => Navigator.of(context)
            .pushNamedAndRemoveUntil(KDashboard, (route) => false));
        // ;
      } catch (error) {
        if (error.toString().isNotEmpty) {
          Get.snackbar('Info!!!', error.toString(),
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.red[200],
          overlayBlur: 0,
          animationDuration: Duration(milliseconds: 1000),
          duration: Duration(seconds: 3));
          // _showShackBar(error.toString());
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
    return Scaffold(
      key: _scaffoldKey,
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
            child: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Image.asset(
            'assets/icons/lg.png',
            height: 40,
          ),
        )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Kindly upload your resume',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff28384F),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              getImage(ImgSource.Both);
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: [6, 6],
                              color: Color(0xff28384F),
                              radius: Radius.circular(30),
                              strokeWidth: 1,
                              child: Container(
                                height: _image1 != null ? 100 : 60,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Upload image here or ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xffC3BBBB),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            'Browse',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Max size file: 1mb',
                                        style: TextStyle(
                                            color: Color(0xffC3BBBB),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                              child: _image1 != null
                                  ? Center(
                                      child: Image.file(
                                        _image1,
                                        height: 250,
                                        width: 150,
                                      ),
                                    )
                                  : Image.asset('assets/images/bg3.png')),
                          SizedBox(
                            height: 40,
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Container(
                  width: double.infinity,
                  child: RoundedRaisedButton(
                    isLoading: _isLoading,
                    title: 'Apply',
                    buttonColor: Color(0xff8C191C),
                    onPress: () {
                      _submitApplication();
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
