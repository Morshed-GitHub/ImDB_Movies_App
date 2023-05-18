import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learning_mvvm/res/components/star_rating_bar.dart';
import 'package:learning_mvvm/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class shimmerLoadingGridView extends StatelessWidget {
  const shimmerLoadingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _isWeb = _width > 450;

    return Align(
      heightFactor: 1.0,
      child: SizedBox(
        width: _isWeb ? 1000 : null,
        child: Shimmer.fromColors(
            child: MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(3),
                  child: Stack(children: [
                    imageSection(),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: infoSection(context),
                    ),
                  ]),
                );
              },
            ),
            baseColor: Colors.white60,
            highlightColor: Colors.white70),
      ),
    );
  }

  Container infoSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: infoDecoration(context),
      child: Column(
        children: [
          SizedBox(height: 3),
          titleSection(),
          SizedBox(height: 5),
          yearSection(),
          SizedBox(height: 6),
          StarRatingBar(rating: "10"),
        ],
      ),
    );
  }

  BoxDecoration infoDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [
        Colors.black12.withOpacity(0),
        Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    );
  }

  Container yearSection() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(20)),
        height: 20,
        width: 60);
  }

  Container titleSection() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(20)),
        height: 20,
        width: 120);
  }

  Container imageSection() {
    return Container(
      height: Utils.getRandomHeight(),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
