import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

class PagedMovieResponse {
  @JsonKey(name: "page")
  int page;

  @JsonKey(name: "results")
  List<Movie> results;

  @JsonKey(name: "total_pages")
  int totalPages;

  @JsonKey(name: "total_results")
  int totalResults;

  PagedMovieResponse(
      this.page, this.results, this.totalPages, this.totalResults);

  factory PagedMovieResponse.fromJson(Map<String, dynamic> json) {
    List list = json["results"];
    List<Movie> movieList =
        List<Movie>.from(list.map((movie) => Movie.fromJson(movie)));

    return PagedMovieResponse(
        json["page"], movieList, json["total_pages"], json["total_results"]);
  }

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results,
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
