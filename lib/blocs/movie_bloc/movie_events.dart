import 'package:equatable/equatable.dart';

class MovieEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchTrendingMovies extends MovieEvents{
  final int page;
  final String mediaType;
  final String movieTimeWindow;

  FetchTrendingMovies(this.mediaType, this.movieTimeWindow, this.page);
}
