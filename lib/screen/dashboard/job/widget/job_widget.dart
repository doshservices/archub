import 'package:archub/model/job_model.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobDate = ModalRoute.of(context).settings.arguments as JobModel;
   final DateFormat formatter = DateFormat.yMMMMd();
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
            child: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Image.asset(
            'assets/icons/lg.png',
            height: 40,
          ),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Center(child: Text(jobDate.companyName)),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Image.network(
            jobDate.logo,
            height: 100,
            width: 100,
          )),
          Center(
              child: SizedBox(
            height: 20,
          )),
          Center(child: Text(jobDate.jobTitle)),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            jobDate.city + ", " + jobDate.country,
            style: TextStyle(color: Color(0xff28384F), fontSize: 12),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.white,
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: RichText(
          //       text: TextSpan(children: [
          //     TextSpan(
          //         text: 'Job title: ',
          //         style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             color: Colors.black)),
          //     TextSpan(
          //         text:
          //             'Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d.',
          //         style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w400,
          //             color: Color(0xff28384F))),
          //   ])),
          // ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Description: ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              TextSpan(
                  text:jobDate.jobDescription,
                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff28384F))),
            ])),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8C191C),
                  decoration: TextDecoration.underline,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text('Date posted',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff28384F),
                      )),
                ),
                Expanded(
                  child: Text(formatter.format(DateTime.parse(jobDate.createdAt)),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff28384F),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text('Job type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff28384F),
                      )),
                ),
                Expanded(
                  child: Text(jobDate.jobDescription,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff28384F),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text('Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff28384F),
                      )),
                ),
                Expanded(
                  child: Text(jobDate.city,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff28384F),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Container(
            width: double.infinity,
            child: RoundedRaisedButton(
              title: 'Next',
              buttonColor: Color(0xff8C191C),
              onPress: (){
                Navigator.of(context).pushNamed(KJobApplication, arguments: jobDate.id);
              },
            ),
          ),
        )
        ]),
      ),
    );
  }
}
