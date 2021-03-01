import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma_flutter/blocs/movie_credit_bloc/movie_credit_api_state.dart';
import 'package:plasma_flutter/blocs/movie_credit_bloc/movie_credit_bloc.dart';
import 'package:plasma_flutter/blocs/movie_credit_bloc/movie_credit_events.dart';
import 'package:plasma_flutter/constants/app_fonts.dart';
import 'package:plasma_flutter/constants/app_images.dart';
import 'package:plasma_flutter/constants/app_strings.dart';
import 'package:plasma_flutter/models/cast.dart';
import 'package:plasma_flutter/models/movie.dart';
import 'package:plasma_flutter/ui/widgets/cast_widget.dart';
import 'package:plasma_flutter/ui/widgets/loading_progress_widget.dart';

class MovieDetailScreen extends StatefulWidget {

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie _movie;
  MovieCreditBloc _movieCreditBloc;


  @override
  void initState() {
    _movieCreditBloc = MovieCreditBloc(MovieCreditLoadingState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _movie = ModalRoute.of(context).settings.arguments;
    _movieCreditBloc.add(FetchMovieCredits(_movie.id, _movie.mediaType));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _createMovieDetail(),
              SizedBox(height: 3),
              Expanded(child: _createMovieCredits()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createMovieDetail() {
    return SizedBox(
      height: 250,
      width: double.maxFinite,
      child: Stack(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) =>
                Image.asset(AppImages.MOVIE_PLACE_HOLDER),
            imageUrl: _movie.getMoviePosterUrl(),
            errorWidget: (context, url, error) =>
                Image.asset(AppImages.MOVIE_PLACE_HOLDER),
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 4,
              padding: EdgeInsets.zero,
              shape: CircleBorder(),
              constraints: BoxConstraints.expand(height: 36, width: 36),
              fillColor: Colors.grey[700],
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        _movie.getMovieTitle(),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.TRUCULENTA,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      SizedBox(height: 3),
                      Text(
                        _movie.overview,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          height: 0.9,
                          fontFamily: AppFonts.TRUCULENTA,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                              child: Text(
                                _movie.mediaType.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.TRUCULENTA,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: Icon(
                              Icons.fiber_manual_record_rounded,
                              size: 8,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            _movie.originalLanguage.toUpperCase(),
                            maxLines: 5,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              height: 0.9,
                              fontFamily: AppFonts.TRUCULENTA,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[300],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: Icon(
                              Icons.fiber_manual_record_rounded,
                              size: 8,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            _movie.voteAverage.toString(),
                            maxLines: 5,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              height: 0.9,
                              fontFamily: AppFonts.TRUCULENTA,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _createMovieCredits() {
    return BlocBuilder(
      cubit: _movieCreditBloc,
      builder: (context, state) {
        if (state is MovieCreditLoadingState) {
          return LoadingProgressWidget();
        } else if (state is MovieCreditLoadedState) {
          return _createCastList(state.creditResponse.cast);
        } else if (state is MovieCreditApiErrorState) {
          return Center(
            child: Text(
              state.error,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: AppFonts.TRUCULENTA,
                  fontWeight: FontWeight.w500),
            ),
          );
        } else {
          throw Exception("Unknown Movie credits state");
        }
      },
    );
  }

  Widget _createCastList(List<Cast> castList) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              AppStrings.CAST,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.TRUCULENTA,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: 4),
          Divider(height: 1, color: Colors.grey[100]),
          SizedBox(height: 4),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.54,
              children: List.generate(
                  castList.length, (index) => CastWidget(castList[index])),
            ),
          )
        ],
      ),
    );
  }
}
