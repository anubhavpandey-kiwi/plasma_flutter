import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SearchEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchMovieEvent extends SearchEvents {
  final String searchQuery;
  final int page;

  SearchMovieEvent({@required this.searchQuery, @required this.page});
}
