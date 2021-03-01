
import 'cast.dart';
import 'crew.dart';

class MovieCreditResponse {
  int id;
  List<Cast> cast;
  List<Crew> crew;

  MovieCreditResponse(this.id, this.cast, this.crew);

  factory MovieCreditResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> castJsonList = json["cast"];
    List<Cast> castList = new List<Cast>.from(
        castJsonList.map((castJson) => Cast.fromJson(castJson)));

    List<dynamic> crewJsonList = json["crew"];
    List<Crew> crewList =
        new List<Crew>.from(crewJsonList.map((crewJson) => Crew.fromJson(crewJson)));

    return MovieCreditResponse(json["id"] as int, castList, crewList);
  }
}
