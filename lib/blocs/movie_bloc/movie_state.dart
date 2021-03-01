
import 'package:equatable/equatable.dart';
import 'package:plasma_flutter/models/paged_movie_response.dart';

class MovieState extends Equatable{
  @override
  List<Object> get props => [];

}

class MovieLoadingState extends MovieState{}

class MovieLoadedState extends MovieState{
  final PagedMovieResponse pagedMovieResponse;

  MovieLoadedState(this.pagedMovieResponse) : assert (pagedMovieResponse != null);
}

class MovieErrorState extends MovieState{
  final String error;

  MovieErrorState(this.error);
}
