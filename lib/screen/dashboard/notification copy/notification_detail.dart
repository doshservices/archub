import 'package:flutter/material.dart';

class NotifictionDetil extends StatelessWidget {
  const NotifictionDetil({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      backgroundColor: Color(0xffF2F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF2F6FA),
        title: Text(
          arguments['title'],
          style: TextStyle(color: Colors.black),
        ),
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
      ),
      body: Container(child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          child: Card(
            elevation: 0,
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(arguments['message']),
          )),
        ),
      )),
    );
  }
}