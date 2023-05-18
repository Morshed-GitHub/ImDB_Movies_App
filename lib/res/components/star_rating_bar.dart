import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatingBar extends StatelessWidget {
  final String? rating;
  final double starSize;
  const StarRatingBar({super.key, required this.rating, this.starSize = 26});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      rating: calculateMovieRating(),
      itemCount: checkRatingCount(),
      itemSize: 26,
      itemBuilder: (context, index) {
        return Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
    );
  }

  double calculateMovieRating() {
    return double.parse(rating ?? "0.0") / 2.0;
  }

  int checkRatingCount() {
    return (calculateMovieRating().toDouble() > 4.0)
        ? 5
        : (calculateMovieRating().toInt() + 1);
  }
}
