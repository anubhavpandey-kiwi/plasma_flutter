import 'package:dio/dio.dart';
import 'package:plasma_flutter/models/movie_credit_response.dart';
import 'package:plasma_flutter/models/paged_movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

/// run 'flutter pub run build_runner build' command after any change

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("trending/{media_type}/{time_window}")
  Future<PagedMovieResponse> getTrendingMovies(
      @Path("media_type") String mediaType,
      @Path("time_window") String timeWindow,
      @Query("page") int page);

  @GET("{media_type}/{id}/credits")
  Future<MovieCreditResponse> getMovieCredits(
      @Path("media_type") String mediaType, @Path("id") int id);

  @GET("search/multi")
  Future<PagedMovieResponse> search(@Query("query")String query, @Query("page")int page);
}
