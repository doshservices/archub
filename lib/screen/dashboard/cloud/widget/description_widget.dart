import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Container(
            width: double.infinity,
            child: RoundedRaisedButton(
              title: 'Next',
              buttonColor: Color(0xff8C191C),
            ),
          ),
        )
      ]),
    );
  }
}
