import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';

class ApplyWidget extends StatelessWidget {
  const ApplyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(children: [
                DistributorTextFormField(
                  labelText: 'Fullname',
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Container(
            width: double.infinity,
            child: RoundedRaisedButton(
              title: 'Apply',
              buttonColor: Color(0xff8C191C),
            ),
          ),
        )
      ]),
    );
  }
}
