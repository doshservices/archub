import 'package:archub/model/imageData.dart';
import 'package:archub/model/post_data.dart';
import 'package:archub/provider/job_provider.dart';
import 'package:archub/provider/user_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class ExploreWidget extends StatefulWidget {
  final String id;
  final String name;

  const ExploreWidget({@required this.id, @required this.name, Key key})
      : super(key: key);

  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  bool _isInit = true;
  bool status;
  List<PostData> categorydata = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      //print(widget.id);
      await Provider.of<UserPost>(context, listen: false)
          .getcategoryUserPort(widget.id);
      if (mounted) {
        setState(() {
        _isInit = false;
      });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<UserPost>(context, listen: false);
    categorydata = categoryProvider.searchByName(widget.name);
    // print(widget.id);
    return Container(
      child: _isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: categorydata.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(KPostDetail,
                      arguments: {"id":categorydata[index].id, "image" : 'http://res.cloudinary.com/archub/image/upload/v1637759465/sjqsgouiagijsvhqzmqn.jpg'});
                },
                child: Image.network(
                  categorydata[index].postFiles[0],
                  fit: BoxFit.fill,
                  // width: MediaQuery.of(context).size.width/2,
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(1, index.isEven ? 1 : 1),
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
            ),
    );
  }
}
