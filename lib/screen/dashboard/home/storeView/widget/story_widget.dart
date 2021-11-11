import 'package:archub/model/post_data.dart';
import 'package:archub/provider/user_post.dart';
import 'package:archub/screen/dashboard/home/storeView/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatefulWidget {
  final PostData user;
  final PageController controller;

  const StoryWidget({
    @required this.user,
    @required this.controller,
  });

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  final storyItems = <StoryItem>[];
  StoryController controller;
  String date = '';

  void addStoryItems() {
    for (final story in widget.user.postFiles) {
      storyItems.add(StoryItem.pageImage(
        url: story.toString().split("'").join(""),
        controller: controller,
        caption: "",
        duration: Duration(
          milliseconds: (5 * 1000).toInt(),
        ),
      ));
      // switch (story.mediaType) {
      //   case MediaType.image:
      //     storyItems.add(StoryItem.pageImage(
      //       url: story.url,
      //       controller: controller,
      //       caption: "story.caption",
      //       duration: Duration(
      //         milliseconds: (story.duration * 1000).toInt(),
      //       ),
      //     ));
      //     break;
      //   case MediaType.text:
      //     storyItems.add(
      //       StoryItem.text(
      //         title: story.caption,
      //         backgroundColor: story.color,
      //         duration: Duration(
      //           milliseconds: (story.duration * 1000).toInt(),
      //         ),
      //       ),
      //     );
      //     break;
      // }
    }
  }

  @override
  void initState() {
    super.initState();

    controller = StoryController();
    addStoryItems();
    date = widget.user.createdAt.toString();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleCompleted() {
    final postlist = Provider.of<UserPost>(context, listen: false).storyData;
    widget.controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final currentIndex = postlist.indexOf(widget.user);
    final isLastPage = postlist.length - 1 == currentIndex;

    if (isLastPage) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: StoryView(
              storyItems: storyItems,
              controller: controller,
              onComplete: handleCompleted,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              },
              onStoryShow: (storyItem) {
                final index = storyItems.indexOf(storyItem);

                if (index > 0) {
                  setState(() {
                    date = widget.user.createdAt;
                  });
                }
              },
            ),
          ),
          ProfileWidget(
            user: widget.user,
            date: date,
          ),
        ],
      );
}
