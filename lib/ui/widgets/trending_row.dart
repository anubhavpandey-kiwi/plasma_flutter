import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma_flutter/blocs/movie_bloc/movie_bloc.dart';
import 'package:plasma_flutter/blocs/movie_bloc/movie_events.dart';
import 'package:plasma_flutter/blocs/movie_bloc/movie_state.dart';
import 'package:plasma_flutter/constants/app_fonts.dart';
import 'package:plasma_flutter/constants/app_strings.dart';
import 'package:plasma_flutter/models/movie.dart';
import 'package:plasma_flutter/models/movie_option.dart';
import 'package:plasma_flutter/ui/screens/view_all_trending_movies.dart';

import 'loading_progress_widget.dart';
import 'movie_widget.dart';

class TrendingRowWidget extends StatefulWidget {
  final MovieOption movieOption;

  TrendingRowWidget(this.movieOption);

  @override
  _TrendingRowWidgetState createState() => _TrendingRowWidgetState(movieOption);
}

class _TrendingRowWidgetState extends State<TrendingRowWidget> {
  final MovieOption _movieOption;

  _TrendingRowWidgetState(this._movieOption);

  MovieBloc _movieBloc;

  @override
  void initState() {
    _movieBloc = MovieBloc(MovieLoadingState());
    _movieBloc.add(FetchTrendingMovies(
        _movieOption.mediaType, _movieOption.timeWindow, 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movieOption.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: AppFonts.TRUCULENTA,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewAllTrendingMovies(_movieOption)));
                    },
                    child: Text(
                      AppStrings.VIEW_ALL,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: AppFonts.TRUCULENTA,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 200,
              child: BlocBuilder<MovieBloc, MovieState>(
                cubit: _movieBloc,
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return LoadingProgressWidget();
                  } else if (state is MovieLoadedState) {
                    List<Movie> movieList = state.pagedMovieResponse.results;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movieList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Movie _movie = movieList[index];
                          return MovieWidget(_movie);
                        });
                  } else if (state is MovieErrorState) {
                    return Text(state.error);
                  } else {
                    throw Exception("Unknown Movie state");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
