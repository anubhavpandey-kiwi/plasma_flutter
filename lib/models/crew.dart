
import 'package:json_annotation/json_annotation.dart';

part 'crew.g.dart';

@JsonSerializable()
class Crew{
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "original_name")
  String originalName;
  @JsonKey(name: "adult")
  bool adult;
  @JsonKey(name: "gender")
  int gender;
  @JsonKey(name: "known_for_department")
  String knownForDepartment;
  @JsonKey(name: "popularity")
  double popularity;
  @JsonKey(name: "profile_path")
  String profilePath;
  @JsonKey(name: "creditId")
  String creditId;
  @JsonKey(name: "department")
  String department;
  @JsonKey(name: "job")
  String job;

  Crew(
      this.id,
      this.name,
      this.originalName,
      this.adult,
      this.gender,
      this.knownForDepartment,
      this.popularity,
      this.profilePath,
      this.creditId,
      this.department,
      this.job);

  factory Crew.fromJson(Map<String,dynamic> json) => _$CrewFromJson(json);
  Map<String,dynamic> toJson() => _$CrewToJson(this);

}