import 'package:archub/model/notification_model.dart';
import 'package:archub/provider/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isInit = true;
  List<NotificationModel> data = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<JobProvider>(context, listen: false).getNotification();
      setState(() {
        _isInit = false;
      });
    }

    // getalldata();
    // startTimer();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    super.initState();
  }

  @override
  void dispose() {
    // _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<JobProvider>(context, listen: false);
    data = value.notifyList;
    return Scaffold(
        backgroundColor: Color(0xffF2F6FA),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffF2F6FA),
          title: Center(
              child: Text(
            "Notification                 ",
            style: TextStyle(color: Colors.black),
          )),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 30,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: _isInit
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 150,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(KNotifictionDetil, arguments: {'title': data.title, 'message':  data.message});
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                                height: 40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: data[index]
                                                  .senderImage
                                                  .contains('/avatar.svg')
                                              ? CircleAvatar(
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.2),
                                                  radius: 25,
                                                  child: SvgPicture.network(
                                                    data[index]
                                                        .senderImage
                                                        .toString()
                                                        .split("'")
                                                        .join(""),
                                                    fit: BoxFit.contain,
                                                    height: 30,
                                                    placeholderBuilder: (BuildContext
                                                            context) =>
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child:
                                                                const CircularProgressIndicator()),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                    data[index].senderImage,
                                                  ),
                                                ),
                                        ),
                                        GestureDetector(
                                          onTap: ()async{
                                            setState(() {
                                              _isInit = true;
                                            });
                                            await Provider.of<JobProvider>(context, listen: false).deleteNotification(data[index].id);
                                            await Provider.of<JobProvider>(context, listen: false).getNotification();
                                            setState(() {
                                              _isInit = false;
                                            });
                                          },
                                            child: Icon(Icons.delete,
                                                color: Colors.grey)
                                          )
                                      ],
                                    ),
                                    // Text(data.title),
                                    SizedBox(height: 15),
                                    Text(
                                      data[index].message,
                                      style: TextStyle(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )),
                          )),
                    ),
                  );
                })

        // PagedListView<int, NotificationModel>(
        //   pagingController: _pagingController,
        //   builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
        //       itemBuilder: (context, data, index) => Column(
        //             children: [
        //               GestureDetector(
        //                 onTap: () {
        //                   // if (data.service == "FUND") {
        //                   //   Navigator.of(context)
        //                   //       .pushNamed(KTransactionWalletDetail, arguments: {
        //                   //     'transref': data.transactionReferenceInit,
        //                   //     'dataValue': data
        //                   //   });
        //                   // } else {
        //                   //   Navigator.of(context).pushNamed(KTransactionDetail,
        //                   //       arguments: {
        //                   //         'transref': data.transactionReferenceInit,
        //                   //         'dataValue': data
        //                   //       });
        //                   // }
        //                 },
        //                 child: Container(
        //                   margin: EdgeInsets.all(10),
        //                   height: 100,
        //                   width: double.infinity,
        //                   child: GestureDetector(
        //                     onTap: (){
        //                       Navigator.of(context).pushNamed(KNotifictionDetil, arguments: {'title': data.title, 'message':  data.message});
        //                     },
        //                     child: Card(
        //                         shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(15)),
        //                         elevation: 0,
        //                         child: Padding(
        //                           padding: const EdgeInsets.all(15),
        //                           child: Container(
        //                               height: 40,
        //                               child: Column(
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: <Widget>[
        //                                   SizedBox(height: 10),
        //                                   Text(data.title),
        //                                   SizedBox(height: 15),
        //                                   Text(
        //                                     data.message,
        //                                     style: TextStyle(color: Colors.grey),
        //                                     overflow: TextOverflow.ellipsis,
        //                                   )
        //                                 ],
        //                               )),
        //                         )),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )),
        // ),
        );
  }
}
