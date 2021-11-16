import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NotificationScreeen extends StatefulWidget {
  const NotificationScreeen({Key key}) : super(key: key);

  @override
  _NotificationScreeenState createState() => _NotificationScreeenState();
}

class _NotificationScreeenState extends State<NotificationScreeen> {
  bool _isLoading = false;
  int initialIndex = 0;
  @override
  Widget build(BuildContext context) {
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
            'assets/icons/not.png',
            height: 70,
          ),
          title: Text(
            "Notification settings",
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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Be notified when you have a new follower',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              ToggleSwitch(
                                minWidth: 30,
                                minHeight: 15,
                                fontSize: 16.0,
                                initialLabelIndex: 1,
                                activeBgColor: Colors.black,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.grey[900],
                                labels: ['', ''],
                                onToggle: (index) {
                                  print('switched to: $index');
                                },
                              ),
                            ]),
                        SizedBox(height: 20),
                        Text(
                          'Project likes',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Be notified when someone likes your project',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              ToggleSwitch(
                                minWidth: 30,
                                minHeight: 15,
                                fontSize: 16.0,
                                initialLabelIndex: 1,
                                activeBgColor: Colors.black,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.grey[900],
                                labels: ['', ''],
                                onToggle: (index) {
                                  print('switched to: $index');
                                },
                              ),
                            ]),
                        SizedBox(height: 20),
                        Text(
                          'Comments',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Be notified when someone comments on your project',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              ToggleSwitch(
                                minWidth: 30,
                                minHeight: 15,
                                fontSize: 16.0,
                                initialLabelIndex: 1,
                                activeBgColor: Colors.black,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.grey[900],
                                labels: ['', ''],
                                onToggle: (index) {
                                  print('switched to: $index');
                                },
                              ),
                            ]),
                        SizedBox(height: 20),
                        Text(
                          'Publish projects',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Be notified when someone you are following post \n a new project',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              ToggleSwitch(
                                minWidth: 30,
                                minHeight: 15,
                                fontSize: 16.0,
                                initialLabelIndex: 1,
                                activeBgColor: Colors.black,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.grey[900],
                                labels: ['', ''],
                                onToggle: (index) {
                                  print('switched to: $index');
                                },
                              ),
                            ]),
                        SizedBox(height: 20),
                        Text(
                          'Publish jobs',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Row(children: [
                          Expanded(
                            child: Text(
                              'Be notified when someone you are following post \na new job',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          ToggleSwitch(
                            minWidth: 30,
                            minHeight: 15,
                            fontSize: 16.0,
                            initialLabelIndex: 1,
                            activeBgColor: Colors.black,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.grey[900],
                            labels: ['', ''],
                            onToggle: (index) {
                              print('switched to: $index');
                            },
                          ),
                        ]),
                        SizedBox(height: 20),
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
              onPress: () {
                setState(() {});
              },
              isLoading: _isLoading,
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
