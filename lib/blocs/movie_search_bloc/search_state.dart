import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:plasma_flutter/models/paged_movie_response.dart';

class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final PagedMovieResponse pagedMovieResponse;

  SearchLoadedState(this.pagedMovieResponse);
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState({@required this.error});
}
