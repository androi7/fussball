class LocationData {
  double? lat;
  double? lng;

  LocationData({
    required this.lat,
    required this.lng,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
