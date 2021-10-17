// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamTest _$TeamTestFromJson(Map<String, dynamic> json) => TeamTest(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      value: json['value'] as int,
      image: json['image'] as String,
      titles: json['titles'] as int,
      stadium: json['stadium'] == null
          ? null
          : Stadium.fromJson(json['stadium'] as Map<String, dynamic>),
      locationData: json['locationData'] == null
          ? null
          : LocationData.fromJson(json['locationData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamTestToJson(TeamTest instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'value': instance.value,
      'image': instance.image,
      'titles': instance.titles,
      'stadium': instance.stadium,
      'locationData': instance.locationData,
    };

Stadium _$StadiumFromJson(Map<String, dynamic> json) => Stadium(
      size: json['size'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$StadiumToJson(Stadium instance) => <String, dynamic>{
      'size': instance.size,
      'name': instance.name,
    };

LocationData _$LocationDataFromJson(Map<String, dynamic> json) => LocationData(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationDataToJson(LocationData instance) =>
    <String, dynamic>{
      'lat': instance.latitude,
      'lng': instance.longitude,
    };
