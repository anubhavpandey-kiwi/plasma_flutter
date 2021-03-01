import 'package:flutter/material.dart';
import 'package:plasma_flutter/constants/app_strings.dart';
import 'package:plasma_flutter/constants/movie_time_window.dart';
import 'package:plasma_flutter/constants/movie_type.dart';
import 'package:plasma_flutter/models/movie_option.dart';
import 'package:plasma_flutter/ui/widgets/trending_row.dart';

class TrendingScreen extends StatelessWidget {
  static final List<MovieOption> movieOptions = [
    MovieOption(
        MovieType.ALL, MovieTimeWindow.WEEK, AppStrings.TRENDING),
    MovieOption(
        MovieType.MOVIE, MovieTimeWindow.DAY, AppStrings.TRENDING_MOVIES),
    MovieOption(
        MovieType.TV, MovieTimeWindow.DAY, AppStrings.TRENDING_TV),
    MovieOption(MovieType.MOVIE, MovieTimeWindow.WEEK,
        AppStrings.TRENDING_MOVIE_THIS_WEEK),
    MovieOption(
        MovieType.TV, MovieTimeWindow.WEEK, AppStrings.TRENDING_TV_THIS_WEEK),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List<TrendingRowWidget>.from(movieOptions.map((option) => TrendingRowWidget(option))),
      ),
    );
  }
}
