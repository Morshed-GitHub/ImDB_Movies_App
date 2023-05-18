import 'package:flutter/material.dart';
import 'package:learning_mvvm/model/movies_ilst_model.dart';
import 'package:learning_mvvm/res/colors.dart';
import 'package:learning_mvvm/res/components/star_rating_bar.dart';

class MovieInfoView extends StatefulWidget {
  final Items movie;

  const MovieInfoView({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieInfoView> createState() => _MovieInfoViewState();
}

class _MovieInfoViewState extends State<MovieInfoView> {
  double _height = 0;
  double _width = 0;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            infoList(),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget infoList() {
    bool isWeb = _width > 500;

    return Align(
      heightFactor: 1.0,
      child: SizedBox(
        width: isWeb ? 500 : null,
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildHeroImage(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildTitle(),
                  SizedBox(height: 15),
                  StarRatingBar(rating: widget.movie.imDbRating),
                  SizedBox(height: 20),
                  _buildInfoRow(),
                  SizedBox(height: 5),
                  _buildCrewDetails(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: widget.movie.title.toString(),
      child: ClipPath(
        clipper:
            HalfCircleClipper(), // Cut circle shape from below part of image
        child: Image.network(
          widget.movie.image!.replaceFirst(
            RegExp(r'_V1_.+'), // Match everything after "_V1_"
            '_V1_Ratio0.6716_AL.jpg', // Replacement string
          ),
          fit: BoxFit.fill,
          height: _height * .7,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      left: 15,
      top: 15,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors
              .click, // Icon changed when user hover over the container
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: AppColors.whiteColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      widget.movie.title!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis, // If overflow from 1 line, then show ...
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 22,
      ),
    );
  }

  Row _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoItem(tag: "Year", property: widget.movie.year!.toString()),
        _buildInfoItem(tag: "Rank", property: widget.movie.rank!.toString()),
        _buildInfoItem(
          tag: "Rating",
          property: widget.movie.imDbRating!.toString(),
          addPreStar: true,
        ),
      ],
    );
  }

  Column _buildInfoItem(
      {required String tag,
      required String property,
      bool addPreStar = false}) {
    return Column(
      children: [
        Text(
          tag,
          style: TextStyle(
            color: AppColors.semiTransparentColor,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 5),
        Text(
          addPreStar ? "⭐ ${property}" : property,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCrewDetails() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
          text: "Crew: ",
          style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: widget.movie.crew!,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 17,
                  height: 1.8, // Space between lines
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 80,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HalfCircleClipper oldClipper) => false;
}
