import 'dart:convert';
import 'dart:io';

import 'package:archub/model/tag.dart';
import 'package:archub/provider/user_post.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
// import 'package:multi_image_picker_demo/themes/device_size.dart';

import '../../../constants.dart';

class PostScreen extends StatefulWidget {
  String title;
  PostScreen({Key key, this.title}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Widget> pages;
  int pageIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  PageController _uploadPageController = PageController(initialPage: 0);
  String imagevalue;
  List<String> postFiles = [];
  List<Asset> images = <Asset>[];
  bool pictureChanged = false;
  GlobalKey<FormState> _locationFormKey = GlobalKey();
  GlobalKey<FormState> _location2FormKey = GlobalKey();
  List<TagData> data;
  TagData _mydata;
  String _location, tagvalue, title, _caption;
  String errMsg = "";
  bool _isLoading = false;
  bool color1 = false;
  bool color2 = false;
  String type;
  List<File> fileImageArray = [];

  File file;
  String status = '';
  String base64Image;
  File _image;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (ctx, index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Archub",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      print(images[0].identifier);
      // File f = await getImageFileFromAssets('images/myImage.jpg');
      // _error = error;
    });
    final cloudinary = Cloudinary(
        "579251194598375", "mURSzkqRNR8_JHjuPJKjMjX3wK0", "dasek9hic");
    images.forEach((imageAsset) async {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      print("+++++++++++++++++ " + filePath.toString());
      File tempFile = File(filePath);
      postFiles.clear();
      if (tempFile.existsSync()) {
        fileImageArray.add(tempFile);
        final response = await cloudinary.uploadFile(
          filePath: tempFile.path,
          resourceType: CloudinaryResourceType.image,
          folder: 'image',
        );
        if (response.isSuccessful ?? false)
          setState(() {
            final String imag1 = response.secureUrl;
            print(imag1);
            postFiles.add('$imag1');
            print(postFiles.length);
          });
      }
    });
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 400,
      maxWidth: 300,
      imageQuality: 100,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    final cloudinary = Cloudinary(
        "579251194598375", "mURSzkqRNR8_JHjuPJKjMjX3wK0", "dasek9hic");
    setState(() {
      _image = image;
      print(_image);
      List<int> imageBytes = _image.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      imagevalue = base64Image;
      print(base64Image);
    });
    final response = await cloudinary.uploadFile(
      filePath: _image.path,
      resourceType: CloudinaryResourceType.image,
      folder: 'image',
    );
    if (response.isSuccessful ?? false)
      setState(() {
        final String imag1 = response.secureUrl;
        print(imag1);
        postFiles.add('$imag1');
        print(postFiles.length);
      });
  }

  Widget page1() {
    return Column(children: [
      Container(
          width: double.infinity,
          color: Colors.white,
          child: Image.asset('assets/images/post.png')),
      Container(
        height: 55,
        color: Color(0xff28384F),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('All Photos',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
              Row(
                children: [
                  Container(
                      height: 35,
                      child: Image.asset('assets/images/folder.png')),
                  SizedBox(width: 15),
                  Container(
                      height: 35,
                      child: Image.asset('assets/images/camera.png'))
                ],
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: GridView.builder(
            // padding: EdgeInsets.all(20),
            shrinkWrap: true,
            primary: false,
            itemCount: 20,
            itemBuilder: (ctx, index) {
              return Container(
                  child: Image.asset(
                'assets/images/img4.png',
                fit: BoxFit.fill,
              ));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 1,
              mainAxisSpacing: 0,
              childAspectRatio: 1 / 1,
            )),
      )
    ]);
  }

  Widget page2() {
    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 10),
                height: 100,
                child: Image.asset('assets/images/flr.png')),
            SizedBox(
              width: 7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add a caption...'),
            )
          ],
        ),
        SizedBox(height: 10),
        Container(height: 4, color: Color(0xffE5E5E5)),
        ListTile(
          title: Text('Tag people'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Container(height: 4, color: Color(0xffE5E5E5)),
        ListTile(
          title: Text('Add location'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color(0xff28384F).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text('Lagos',
                        style: TextStyle(
                            color: Color(0xff28384F).withOpacity(0.5))),
                  )),
              SizedBox(width: 10),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff28384F).withOpacity(0.5), width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text('Omole estate, ojodu',
                        style: TextStyle(
                            color: Color(0xff28384F).withOpacity(0.5))),
                  )),
              SizedBox(width: 10),
              Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color(0xff28384F).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text('Oke-ira',
                        style: TextStyle(
                            color: Color(0xff28384F).withOpacity(0.5))),
                  )),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(height: 4, color: Color(0xffE5E5E5)),
        ListTile(
          title: Text('Choose'),
          // trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color(0xff28384F).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff28384F)),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text('Post', style: TextStyle(color: Colors.white)),
                  )),
              SizedBox(width: 10),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff28384F).withOpacity(0.5), width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text('Story',
                        style: TextStyle(
                            color: Color(0xff28384F).withOpacity(0.5))),
                  )),
            ],
          ),
        )
      ]),
    );
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

  Future<void> _submitLogin() async {
    if (postFiles.length == 0) {
      _showShackBar('Please click on image to select picture');
      return;
    }
    if (!_location2FormKey.currentState.validate()) {
      return;
    }
    if (tagvalue == null) {
      _showShackBar('Please click on image to select picture');
      return;
    }
    if (widget.title == null) {
      _showShackBar('Please select post type');
      return;
    }
    _location2FormKey.currentState.save();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
        type = widget.title.toLowerCase();
      });
      print("description = " + _caption.toString());
      try {
        await Provider.of<UserPost>(context, listen: false)
            .creatPost(postFiles, _location, tagvalue, _caption, type);

        Get.snackbar('Success!', 'Post/Story Created Succesfully',
            barBlur: 0,
            dismissDirection: SnackDismissDirection.VERTICAL,
            backgroundColor: Colors.green,
            overlayBlur: 0,
            animationDuration: Duration(milliseconds: 500),
            duration: Duration(seconds: 2));
        await Provider.of<UserPost>(context, listen: false).getAllUserPort();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(KDashboard, (route) => false);
      } catch (error) {
        if (error.toString().isNotEmpty) {
          _showShackBar(error.toString());
          setState(() {
            errMsg = error.toString();
          });
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Not connected');
      _showShackBar('Please check your Internet connection!!!');
      setState(() {
        errMsg = "Invalid credential";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final banklist = Provider.of<UserPost>(context, listen: false).tagData;
    setState(() {
      data = banklist;
    });
    pages = [
      page2(),
      // page2(),
    ];

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        title: Center(
            child: Padding(
          padding: EdgeInsets.only(right: 40),
          child: Image.asset(
            'assets/icons/lg.png',
            height: 40,
          ),
        )),
      ),
      body: Column(children: [
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('  ',
                      style: TextStyle(fontSize: 16, color: Color(0xff28384F))),
                  Text('New ${widget.title}',
                      style: TextStyle(fontSize: 16, color: Color(0xff28384F))),
                  GestureDetector(
                    onTap: () {
                      _submitLogin();
                    },
                    child: _isLoading == true
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator())
                        : Text("Share",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff8C191C))),
                  ),
                ]),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
            child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 100,
                          child: GestureDetector(
                              onTap: loadAssets,
                              // () {
                              //   loadAssets;
                              //   // getImage(ImgSource.Both);
                              // },
                              child: _image != null
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset('assets/images/flr.png'))),
                      Expanded(
                          child: Container(height: 100, child: buildGridView()))
                    ],
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _location2FormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusColor: Colors.black,
                                hintText: "Add Title...",
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
                                _location = value;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(height: 4, color: Color(0xffE5E5E5)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusColor: Colors.black,
                                hintText: "Add a description...",
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
                                _caption = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text('Add a caption...'),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Container(height: 4, color: Color(0xffE5E5E5)),
              Card(
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TagData>(
                        hint: Text("Select Tag"),
                        value: _mydata,
                        onChanged: (TagData value) {
                          setState(() {
                            _mydata = value;
                            tagvalue = value.id;
                            print(value.id);
                          });
                        },
                        items:
                            data.map<DropdownMenuItem<TagData>>((TagData item) {
                          return DropdownMenuItem<TagData>(
                            child: new SizedBox(
                                width: 300,
                                child: new Text(
                                  item.name.toString(),
                                  style: TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            value: item,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Container(height: 4, color: Color(0xffE5E5E5)),
              // SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 20,
              //   ),
              //   child: Text('Select Post Type'),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             color1 = true;
              //             color2 = false;
              //             type = "post";
              //           });
              //         },
              //         child: Container(
              //             decoration: BoxDecoration(
              //                 border: Border.all(width: 1, color: Colors.black),
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: color1 == true
              //                     ? Color(0xff8C191C)
              //                     : Colors.white),
              //             child: Padding(
              //               padding: const EdgeInsets.all(10),
              //               child: Text('post'),
              //             )),
              //       ),
              //       SizedBox(width: 20),
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             color1 = false;
              //             color2 = true;
              //             type = "story";
              //           });
              //         },
              //         child: Container(
              //             decoration: BoxDecoration(
              //                 border: Border.all(width: 1, color: Colors.black),
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: color2 == true
              //                     ? Color(0xff8C191C)
              //                     : Colors.white),
              //             child: Padding(
              //               padding: const EdgeInsets.all(10),
              //               child: Text('story'),
              //             )),
              //       )
              //     ],
              //   ),
              // ),
              // ElevatedButton(
              //   child: Text("Pick images"),
              //   onPressed: loadAssets,
              // ),
              // Container(height: 100, child: buildGridView())
              // Expanded(
              //   child: buildGridView(),
              // ),
              // Form(
              //   key: _locationFormKey,
              //   child: Column(
              //     children: [
              //       // SizedBox(height: 10),
              //       // Container(height: 4, color: Color(0xffE5E5E5)),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 20),
              //         child: TextFormField(
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w400,
              //               fontStyle: FontStyle.normal),
              //           decoration: InputDecoration(
              //             border: InputBorder.none,
              //             focusColor: Colors.black,
              //             hintText: "Enter Location",
              //             hintStyle: TextStyle(
              //               fontSize: 16,
              //               color: Color(0xffC3BBBB),
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //           // validator: (value) {
              //           //   if (value.isEmpty) {
              //           //     return "required";
              //           //   } else {
              //           //     return null;
              //           //   }
              //           // },
              //           onSaved: (value) {
              //             title = value;
              //           },
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       Container(height: 4, color: Color(0xffE5E5E5)),
              //     ],
              //   ),
              // ),
              // ListTile(
              //   title: Text('Choose'),
              //   // trailing: Icon(Icons.keyboard_arrow_right),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     children: [
              //       Container(
              //           decoration: BoxDecoration(
              //               border: Border.all(
              //                   color: Color(0xff28384F).withOpacity(0.5)),
              //               borderRadius: BorderRadius.circular(20),
              //               color: Color(0xff28384F)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(7),
              //             child:
              //                 Text('Post', style: TextStyle(color: Colors.white)),
              //           )),
              //       SizedBox(width: 10),
              //       Container(
              //           decoration: BoxDecoration(
              //               border: Border.all(
              //                   color: Color(0xff28384F).withOpacity(0.5),
              //                   width: 1),
              //               borderRadius: BorderRadius.circular(20)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(7),
              //             child: Text('Story',
              //                 style: TextStyle(
              //                     color: Color(0xff28384F).withOpacity(0.5))),
              //           )),
              //     ],
              //   ),
              // )
            ]),
          ),
        )
            // PageView(
            //   physics: NeverScrollableScrollPhysics(),
            //   controller: _uploadPageController,
            //   onPageChanged: (index) {
            //     setState(() {
            //       pageIndex = index;
            //     });
            //   },
            //   children: [...pages],
            // ),
            ),
      ]),
    );
  }
}
