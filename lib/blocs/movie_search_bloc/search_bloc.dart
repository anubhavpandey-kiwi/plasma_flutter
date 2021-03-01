import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma_flutter/blocs/movie_search_bloc/search_events.dart';
import 'package:plasma_flutter/blocs/movie_search_bloc/search_state.dart';
import 'package:plasma_flutter/models/paged_movie_response.dart';
import 'package:plasma_flutter/network/rest_context.dart';

class SearchBloc extends Bloc<SearchEvents, SearchState> {
  bool isDataFetching = false;
  bool hasNextPage = true;

  SearchBloc(SearchState initialState) : super(initialState);

  @override
  Stream<SearchState> mapEventToState(SearchEvents event) async* {
    if (event is SearchMovieEvent) {
      isDataFetching = true;
      yield SearchLoadingState();
      try {
        PagedMovieResponse pagedMovieResponse =
            await RestContext().apiClient.search(event.searchQuery, event.page);
        yield SearchLoadedState(pagedMovieResponse);
      } catch (e) {
        yield SearchErrorState(error: e.toString());
      }
      isDataFetching = false;
    }
  }
}
