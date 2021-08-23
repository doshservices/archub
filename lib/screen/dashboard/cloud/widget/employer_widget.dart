import 'package:archub/screen/dashboard/cloud/widget/company_widget.dart';
import 'package:archub/screen/dashboard/cloud/widget/description_widget.dart';
import 'package:archub/screen/dashboard/cloud/widget/job_application.dart';
import 'package:flutter/material.dart';

class EmployerWidget extends StatefulWidget {
  const EmployerWidget({ Key key }) : super(key: key);

  @override
  _EmployerWidgetState createState() => _EmployerWidgetState();
}

class _EmployerWidgetState extends State<EmployerWidget> with TickerProviderStateMixin{
  TabController _controller2;
  @override
  void initState() {
   
    _controller2 = new TabController(length: 3,vsync: this);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              DefaultTabController(
                  length: 3,
                  child: TabBar(
                    controller: _controller2,
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: "DosisBold",
                        fontWeight: FontWeight.w800,
                      ),
                      indicatorColor: Color(0xff28384F),
                      unselectedLabelColor: Color(0xffC4C4C4),
                      labelPadding: EdgeInsets.symmetric(horizontal: 20),
                      isScrollable:false,
                      tabs: [
                        Tab(child: Row(
                          children: [
                            Text('Company Details', style: TextStyle(color: Color(0xff28384F),
                              fontSize: 10),),
                            Expanded(child: Text(''))
                          ],
                        ),),
                        Tab(child: Row(
                          children: [
                            Expanded(child: Text('')),
                            Text('Description', style: TextStyle(
                              color: Color(0xff28384F),
                              fontSize:10
                            ),
                          ),
                          ],
                        ),),
                        Tab(child: Row(
                          children: [
                            Expanded(child: Text('')),
                            Text('Job Application', style: TextStyle(
                              color: Color(0xff28384F),
                              fontSize: 10
                            ),
                          ),
                          ],
                        ),),
                      ]
                  )
              ),
              Expanded(
                child: Container(
                  color: Color(0xffE5E5E5),
                  child: TabBarView(
                    controller: _controller2,
                    children: [
                      CompanyWidget(),
                      DescriptionWidget(),
                      JobApplicationWidget(),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
    );
  }
}