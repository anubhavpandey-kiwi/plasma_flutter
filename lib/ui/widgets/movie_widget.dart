import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma_flutter/constants/app_fonts.dart';
import 'package:plasma_flutter/constants/app_images.dart';
import 'package:plasma_flutter/constants/routes.dart';
import 'package:plasma_flutter/models/movie.dart';

class MovieWidget extends StatelessWidget {
  final Movie _movie;

  MovieWidget(this._movie);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.MOVIE_DETAIL_SCREEN,arguments: _movie);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SizedBox(
          width: 120,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(AppImages.MOVIE_PLACE_HOLDER),
                    imageUrl: _movie.getMoviePosterUrl(),
                    errorWidget: (context, url, error) => Image.asset(AppImages.MOVIE_PLACE_HOLDER),
                  ),
                ),
              ),
              Text(
                _movie.getMovieTitle(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: AppFonts.TRUCULENTA,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                _movie.getReleaseDate(),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: AppFonts.TRUCULENTA,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
