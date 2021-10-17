import 'package:json_annotation/json_annotation.dart';

part 'team_test.g.dart';

@JsonSerializable()
class TeamTest {
  TeamTest({
    required this.id,
    required this.name,
    required this.country,
    required this.value,
    required this.image,
    required this.titles,
    this.stadium,
    this.locationData,
  });

  factory TeamTest.fromJson(Map<String, dynamic> json) =>
      _$TeamTestFromJson(json);

  Map<String, dynamic> toJson() => _$TeamTestToJson(this);

  String id;
  String name;
  String country;
  int value;
  String image;
  int titles;
  Stadium? stadium;
  LocationData? locationData;
}

@JsonSerializable()
class Stadium {
  Stadium({
    required this.size,
    required this.name,
  });

  factory Stadium.fromJson(Map<String, dynamic> json) =>
      _$StadiumFromJson(json);

  Map<String, dynamic> toJson() => _$StadiumToJson(this);

  int size;
  String name;
}

@JsonSerializable()
class LocationData {
  LocationData({
    required this.latitude,
    required this.longitude,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);

  @JsonKey(name: 'lat')
  double latitude;
  @JsonKey(name: 'lng')
  double longitude;
}
