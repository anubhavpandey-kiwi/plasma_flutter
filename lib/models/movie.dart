import 'package:json_annotation/json_annotation.dart';
import 'package:plasma_flutter/network/rest_context.dart';
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "original_title")
  String originalTitle;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "overview")
  String overview;
  @JsonKey(name: "release_date")
  String releaseDate;
  @JsonKey(name: "first_air_date")
  String firstAirDate;
  @JsonKey(name: "poster_path")
  String posterPath;
  @JsonKey(name: "original_language")
  String originalLanguage;
  @JsonKey(name: "popularity")
  double popularity;
  @JsonKey(name: "media_type")
  String mediaType;
  @JsonKey(name: "backdrop_path")
  String backdropPath;
  @JsonKey(name: "genre_ids")
  List<int> genreIds;
  @JsonKey(name: "adult")
  bool adult;
  @JsonKey(name: "voteCount")
  int voteCount;
  @JsonKey(name: "vote_average")
  double voteAverage;
  @JsonKey(name: "video")
  bool video;

  Movie(
      this.id,
      this.originalTitle,
      this.title,
      this.name,
      this.overview,
      this.releaseDate,
      this.firstAirDate,
      this.posterPath,
      this.originalLanguage,
      this.popularity,
      this.mediaType,
      this.backdropPath,
      this.genreIds,
      this.adult,
      this.voteCount,
      this.voteAverage,
      this.video);

  String getMoviePosterUrl(){
    return posterPath!= null ? RestContext.POSTER_PATH + posterPath : "";
  }

  String getMovieTitle(){
    return title ?? originalTitle ?? name ?? "";
  }

  String getReleaseDate(){
    return releaseDate ?? firstAirDate ?? "";
  }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
