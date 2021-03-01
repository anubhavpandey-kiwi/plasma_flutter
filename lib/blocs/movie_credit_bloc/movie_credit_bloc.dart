import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma_flutter/models/movie_credit_response.dart';
import 'package:plasma_flutter/network/rest_context.dart';

import 'movie_credit_api_state.dart';
import 'movie_credit_events.dart';

class MovieCreditBloc extends Bloc<MovieCreditEvents, MovieCreditApiState> {
  MovieCreditBloc(MovieCreditApiState initialState) : super(initialState);

  @override
  Stream<MovieCreditApiState> mapEventToState(
      MovieCreditEvents event) async* {
    if (event is FetchMovieCredits) {
      yield MovieCreditLoadingState();

      try {
        MovieCreditResponse creditResponse = await RestContext()
            .apiClient
            .getMovieCredits(event.mediaType, event.id);
        yield MovieCreditLoadedState(creditResponse);
      } catch (e) {
        yield MovieCreditApiErrorState(e.toString());
      }
    }
  }
}
