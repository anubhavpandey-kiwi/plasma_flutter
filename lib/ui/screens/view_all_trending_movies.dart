import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma_flutter/blocs/movie_bloc/movie_bloc.dart';
import 'package:plasma_flutter/blocs/movie_bloc/movie_events.dart';
import 'package:plasma_flutter/blocs/movie_bloc/movie_state.dart';
import 'package:plasma_flutter/constants/app_fonts.dart';
import 'package:plasma_flutter/models/movie.dart';
import 'package:plasma_flutter/models/movie_option.dart';
import 'package:plasma_flutter/ui/widgets/loading_progress_widget.dart';
import 'package:plasma_flutter/ui/widgets/movie_widget.dart';

class ViewAllTrendingMovies extends StatefulWidget {
  final MovieOption _movieOption;

  ViewAllTrendingMovies(this._movieOption);

  @override
  _ViewAllTrendingMoviesState createState() =>
      _ViewAllTrendingMoviesState(_movieOption);
}

class _ViewAllTrendingMoviesState extends State<ViewAllTrendingMovies> {
  final MovieOption _movieOption;
  MovieBloc _movieBloc;
  List<Movie> _movieList = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;

  _ViewAllTrendingMoviesState(this._movieOption);

  @override
  void initState() {
    _movieBloc = MovieBloc(MovieLoadingState());
    _movieBloc.add(FetchTrendingMovies(
        _movieOption.mediaType, _movieOption.timeWindow, _page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          widget._movieOption.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFonts.TRUCULENTA,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: BlocBuilder<MovieBloc, MovieState>(
            cubit: _movieBloc,
            builder: (context, state) {
              if (state is MovieLoadingState && _page == 1) {
                return LoadingProgressWidget();
              } else if (state is MovieErrorState && _page == 1) {
                return Text(
                  state.error,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: AppFonts.TRUCULENTA,
                      fontWeight: FontWeight.w700),
                );
              } else if (state is MovieErrorState) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Error Loading Next page")));
              } else if (state is MovieLoadedState) {
                _movieBloc.hasNextPage =
                    state.pagedMovieResponse.totalPages > _page;
                _movieList.addAll(state.pagedMovieResponse.results);
              }
              return GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 0.5,
                children: List.generate(_movieList.length,
                        (index) => MovieWidget(_movieList[index])),
                controller: _scrollController
                  ..addListener(() {
                    if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                        !_movieBloc.isFetching && _movieBloc.hasNextPage) {
                      _movieBloc.isFetching = true;
                      _movieBloc.add(FetchTrendingMovies(_movieOption.mediaType,
                          _movieOption.timeWindow, ++_page));
                    }
                  }),
              );
            }),
      ),
    );
  }
}
