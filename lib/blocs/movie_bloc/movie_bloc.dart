import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma_flutter/models/paged_movie_response.dart';
import 'package:plasma_flutter/network/rest_context.dart';

import 'movie_events.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvents, MovieState> {
  bool isFetching = false;
  bool hasNextPage = true;

  MovieBloc(MovieState initialState) : super(initialState);


  @override
  Stream<MovieState> mapEventToState(MovieEvents event) async* {
    if (event is FetchTrendingMovies) {
      yield MovieLoadingState();
      isFetching = true;
      try {
        PagedMovieResponse pagedMovieResponse = await RestContext().apiClient
            .getTrendingMovies(
            event.mediaType, event.movieTimeWindow,
            event.page);
        yield MovieLoadedState(pagedMovieResponse);
      } catch (e) {
        print(e);
        yield MovieErrorState(e.toString());
      }
      isFetching = false;
    }
  }
}
