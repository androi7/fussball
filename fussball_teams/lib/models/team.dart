import 'stadium.dart';
import 'location_data.dart';

class Team {
  String id;
  String name;
  String country;
  int? value;
  String image;
  int? titles;
  Stadium stadium;
  LocationData? location;

  Team({
    required this.id,
    required this.name,
    required this.country,
    required this.value,
    required this.image,
    this.titles,
    required this.stadium,
    required this.location,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    late Stadium stadium;
    late LocationData location;

    if (json['stadium'] != null) {
      stadium = Stadium.fromJson(json['stadium']);
    }

    if (json['location'] != null) {
      location = LocationData.fromJson(json['location']);
    }

    return Team(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      value: json['value'],
      image: json['image'] ?? '',
      titles: json['european_titles'],
      stadium: stadium,
      location: location,
    );
  }
}
