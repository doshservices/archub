import 'package:archub/model/post_data.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/provider/job_provider.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReportPort extends StatefulWidget {
  ReportPort({Key key}) : super(key: key);

  @override
  _ReportPortState createState() => _ReportPortState();
}

class _ReportPortState extends State<ReportPort> {
  bool isLoading = false;
  List<dynamic> report = [
    'It’s Spam',
    'Nudity or sexual activity',
    'Hate speech or symbols',
    'Hate speech or symbols',
    'Bullying or harassment',
    'False information',
    'Violence or dangerous organization',
    'I just don’t like it',
    'Scam or Fraud',
    'Intellectual property violation',
    'Sale of Illegal or regulated goods',
  ];
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
      ),
      body: Column(children: [
        Container(
            height: 80,
            color: Colors.white,
            child: Center(
              child: Text('Report a post'),
            )),
        Container(
            height: 60,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Why are you reporting this post?'),
                ))),
        Container(
          height: 1.5,
          width: double.infinity,
          color: Color(0xffB2B6CD),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: report.length,
              itemBuilder: (ctx, index) {
                return Column(children: [
                  Container(
                      height: 60,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return Dialog(
                                          child: Container(
                                            height: 160,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              child: Column(
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Confirm you want to proceed",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                  SizedBox(height: 30),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
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
                                                                      .circular(
                                                                          30)),
                                                          child:
                                                              RoundedRaisedButton(
                                                            title:
                                                                'Proceed',
                                                            titleColor:
                                                                Colors.white,
                                                            buttonColor: Color(
                                                                0xff8C191C),
                                                            onPress: () async{
                                                              Navigator.of(context).pop();
                                                              final arguement = ModalRoute.of(context).settings.arguments as PostData;
                                                              print(arguement.sourceId);
                                                              try{
                                                                setState(() {
                                                                  isLoading = true;
                                                                });
                                                                await Provider.of<JobProvider>(context, listen: false).reportPost(arguement.id, arguement.sourceId['_id'], report[index]);
                                                                Get.snackbar('Success!', 'User successfully reported!!!',
                                                                barBlur: 0,
                                                                dismissDirection: SnackDismissDirection.VERTICAL,
                                                                backgroundColor: Colors.green,
                                                                overlayBlur: 0,
                                                                animationDuration: Duration(milliseconds: 500),
                                                                duration: Duration(seconds: 2));
                                                                setState(() {
                                                                  isLoading = false;
                                                                });
                                                                Future.delayed(Duration(seconds: 2)).then((value){
                                                                  Navigator.of(context).pop();
                                                                });
                                                                
                                                              }catch(e){

                                                              }                                           
                                                              // Navigator.of(context).pushNamed(KReportPort);
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
                                child: Text(report[index])),
                          ))),
                  Container(
                    height: 1.5,
                    width: double.infinity,
                    color: Color(0xffB2B6CD),
                  )
                ]);
              }),
        )
      ]),
    );
  }
}
