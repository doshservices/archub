import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { Prepaid, Postpaid, Option }

class EmployerWidget extends StatefulWidget {
  const EmployerWidget({Key key}) : super(key: key);

  @override
  _EmployerWidgetState createState() => _EmployerWidgetState();
}

class _EmployerWidgetState extends State<EmployerWidget>
    with TickerProviderStateMixin {
  SingingCharacter _character = SingingCharacter.Prepaid;
  TabController _controller2;
  List<Widget> pages;
  PageController _uploadPageController = PageController(initialPage: 0);
  int pageIndex = 0;
  @override
  void initState() {
    _controller2 = new TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget page1 = SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 25),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(children: [
                DistributorTextFormField(
                  labelText: 'Company Name',
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: [6, 6],
                  color: Color(0xff28384F),
                  radius: Radius.circular(30),
                  strokeWidth: 1,
                  child: Container(
                    height: 60,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(height: 10),
                DistributorTextFormField(
                  labelText: 'Staff capacity',
                ),
                DistributorTextFormField(
                  labelText: 'Contact email',
                ),
                DistributorTextFormField(
                  labelText: 'Enquiry phone number',
                ),
                DistributorTextFormField(
                  labelText: 'Country',
                ),
                DistributorTextFormField(
                  labelText: 'City',
                ),
                SizedBox(height: 25),
              ]),
            ),
          ),
        ]),
      ),
    );

    Widget page2 = SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 25),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(children: [
                DistributorTextFormField(
                  labelText: 'Job title',
                ),
                DistributorTextFormField(
                  labelText: 'Salary',
                ),
                DistributorTextFormField(
                  labelText: 'Job description',
                ),
                SizedBox(height: 100),
              ]),
            ),
          ),
        ]),
      ),
    );

    Widget page3 = SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 25),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(children: [
                DistributorTextFormField(
                  labelText: 'Applications for this job would be sent to ',
                ),
                DistributorTextFormField(
                  labelText: 'Additional instructions',
                ),
                SizedBox(height: 25),
                Text('Would you like applicants to submit resume?',
                    textAlign: TextAlign.left),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio(
                          value: SingingCharacter.Prepaid,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            // setState(() {
                            //   _character = value;
                            //   purchaseOption = "PREPAID";
                            //   print(_character);
                            // });
                          },
                        ),
                        const Text('Yes'),
                      ],
                    ),
                    Row(children: [
                      Radio(
                        value: SingingCharacter.Postpaid,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          // setState(() {
                          //   _character = value;
                          //   purchaseOption = "POSTPAID";
                          //   print(_character);
                          // });
                        },
                      ),
                      const Text('No'),
                    ]),
                    Row(children: [
                      Radio(
                        value: SingingCharacter.Postpaid,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          // setState(() {
                          //   _character = value;
                          //   purchaseOption = "POSTPAID";
                          //   print(_character);
                          // });
                        },
                      ),
                      const Text('Optional'),
                    ]),
                  ],
                ),
                SizedBox(height: 70)
              ]),
            ),
          ),
        ]),
      ),
    );

    pages = [
      page1,
      page2,
      page3,
    ];

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Text('Company Details'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(width: 120, height: 3, color: Colors.grey)
                  ]),
                  Column(children: [
                    Text('Description'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(width: 120, height: 3, color: Colors.grey)
                  ]),
                  Column(children: [
                    Text('Job Application'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(width: 120, height: 3, color: Colors.grey)
                  ]),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _uploadPageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                children: [...pages],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Container(
                width: double.infinity,
                child: RoundedRaisedButton(
                  title: 'Next',
                  buttonColor: Color(0xff8C191C),
                  onPress: pageIndex == pages.length - 1
                          ? () async {
                              // if (_image == null) {
                              //   _showShackBar(
                              //       "Please upload the property main image");
                              //   return;
                              // }
                              try {
                                // print("Image legnth : ${property.images.length}");
                                // await Provider.of<PropertyProvider>(context,
                                //         listen: false)
                                //     .uploadProperty(property);
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text("Uploaded"),
                                        content: Text(
                                            "Your product has been successfully uploaded"),
                                        actions: [
                                          FlatButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              // Navigator.of(context)
                                              //     .pushNamedAndRemoveUntil(
                                              //         kHome, (route) => false);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              } catch (error) {
                                print(error);
                                // _showShackBar(
                                //     "Property Upload failed, try again!");
                              } finally {
                                setState(() {
                                  // _isLoading = false;
                                });
                              }
                            }
                          : 
                          () {
                              if (pageIndex < pages.length - 1) {
                                try {
                                  // validatePage(pageIndex);
                                  _uploadPageController.animateToPage(
                                    ++pageIndex,
                                    duration: Duration(microseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                } catch (error) {}
                              }
                            },
                ),
              ),
            )
            // Expanded(
            //   child: Container(
            //     color: Color(0xffE5E5E5),
            //     child: TabBarView(
            //       controller: _controller2,
            //       children: [
            //         CompanyWidget(),
            //         DescriptionWidget(),
            //         JobApplicationWidget(),
            //       ],
            //     ),
            //   )
            // ),
          ],
        ),
      ),
    );
  }
}
