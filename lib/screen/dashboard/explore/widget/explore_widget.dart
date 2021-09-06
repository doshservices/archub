import 'package:archub/model/imageData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../constants.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({Key key}) : super(key: key);

  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  @override
  Widget build(BuildContext context) {
    final imageList = [
      ImageData(id: '1', image: 'assets/images/img1.png'),
      ImageData(id: '2', image: 'assets/images/img2.png'),
      ImageData(id: '3', image: 'assets/images/img3.png'),
      ImageData(id: '4', image: 'assets/images/img4.png'),
      ImageData(id: '5', image: 'assets/images/img5.png'),
      ImageData(id: '6', image: 'assets/images/img6.png'),
      ImageData(id: '7', image: 'assets/images/img7.png'),
      ImageData(id: '8', image: 'assets/images/img8.png'),
      ImageData(id: '9', image: 'assets/images/img9.png'),
      ImageData(id: '10', image: 'assets/images/img10.png'),
    ];
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: imageList.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(KPostDetail);
        },
        child: Image.asset(
          imageList[index].image,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
    );
  }
}
