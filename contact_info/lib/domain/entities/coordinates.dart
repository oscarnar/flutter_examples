class Coordinates {
  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: double.parse(json['lat'].toString()),
      longitude: double.parse(json['lng'].toString()),
    );
  }
  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
