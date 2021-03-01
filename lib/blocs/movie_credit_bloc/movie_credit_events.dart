import 'package:equatable/equatable.dart';

class MovieCreditEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchMovieCredits extends MovieCreditEvents{
  final int id;
  final String mediaType;

  FetchMovieCredits(this.id, this.mediaType);
}
