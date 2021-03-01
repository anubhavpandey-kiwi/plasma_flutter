
import 'package:json_annotation/json_annotation.dart';
import 'package:plasma_flutter/network/rest_context.dart';
part 'cast.g.dart';

@JsonSerializable()
class Cast{
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "cast_id")
  int castId;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "original_name")
  String originalName;
  @JsonKey(name : "character")
  String character;
  @JsonKey(name: "credit_id")
  String creditId;
  @JsonKey(name: "gender")
  int gender;
  @JsonKey(name: "order")
  int order;
  @JsonKey(name: "profile_path")
  String profilePath;
  @JsonKey(name: "adult")
  bool adult;
  @JsonKey(name: "known_for_department")
  String knownForDepartment;
  @JsonKey(name: "popularity")
  double popularity;



  Cast(
      this.id,
      this.name,
      this.originalName,
      this.character,
      this.creditId,
      this.gender,
      this.order,
      this.profilePath,
      this.adult,
      this.knownForDepartment,
      this.popularity,
      this.castId);

  String getCastProfileUrl(){
    if(profilePath != null){
      return RestContext.POSTER_PATH + profilePath;
    }
    return "";
  }

  factory Cast.fromJson(Map<String,dynamic> json) => _$CastFromJson(json);

  Map<String,dynamic> toJson() => _$CastToJson(this);
}