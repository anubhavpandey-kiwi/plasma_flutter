import 'package:equatable/equatable.dart';
import 'package:plasma_flutter/models/movie_credit_response.dart';

class MovieCreditApiState extends Equatable{
  @override
  List<Object> get props => [];
}

class MovieCreditLoadingState extends MovieCreditApiState{}

class MovieCreditLoadedState extends MovieCreditApiState{
  final MovieCreditResponse creditResponse;

  MovieCreditLoadedState(this.creditResponse);
}

class MovieCreditApiErrorState extends MovieCreditApiState{
  final String error;

  MovieCreditApiErrorState(this.error);
}