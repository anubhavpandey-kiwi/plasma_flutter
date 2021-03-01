import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plasma_flutter/constants/app_fonts.dart';
import 'package:plasma_flutter/constants/app_images.dart';
import 'package:plasma_flutter/models/cast.dart';

class CastWidget extends StatelessWidget {
  final Cast _cast;

  CastWidget(this._cast);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            placeholder: (context, url) => Image.asset(AppImages.MOVIE_PLACE_HOLDER),
            imageUrl: _cast.getCastProfileUrl(),
            errorWidget: (context, url, error) => Image.asset(AppImages.MOVIE_PLACE_HOLDER),
            fit: BoxFit.cover,
          ),
        ),
        Text(
          _cast.character ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: AppFonts.TRUCULENTA,
              fontWeight: FontWeight.w500),
        ),
        Text(
          _cast.name ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.TRUCULENTA,
              fontWeight: FontWeight.w500),
        )
      ]),
    );
  }
}
