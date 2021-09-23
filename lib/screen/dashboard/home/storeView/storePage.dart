// import 'package:archub/model/post_data.dart';
// import 'package:archub/provider/user_post.dart';
// import 'package:archub/screen/dashboard/home/storeView/widget/story_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class StoryPage extends StatefulWidget {
//   final PostData store;

//   const StoryPage({
//     @required this.store,
//     Key key,
//   }) : super(key: key);

//   @override
//   _StoryPageState createState() => _StoryPageState();
// }

// class _StoryPageState extends State<StoryPage> {
//   PageController controller;

//   @override
//   void initState() {
//     super.initState();
//     final stores = Provider.of<UserPost>(context, listen: false).storyData;

//     final initialPage = stores.indexOf(widget.store);
//     controller = PageController(initialPage: initialPage);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) { 
//     final stores = Provider.of<UserPost>(context, listen: false).storyData;
//     return PageView(
//         controller: controller,
//         children: stores
//             .map((user) => StoryWidget(
//                   user: user,
//                   controller: controller,
//                 ))
//             .toList(),
//       );
//     }
// }