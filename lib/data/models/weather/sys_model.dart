class SysModel {
  final num type;
  final num id;
  final num sunrise;
  final num sunset;
  final String country;

  SysModel(
      {required this.id,
      required this.type,
      required this.sunrise,
      required this.country,
      required this.sunset});

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
        id: json["id"] as num? ?? 0,
        type: json["type"] as num? ?? 0,
        sunrise: json["sunrise"] as num? ?? 0,
        country: json["country"] as String? ?? "",
        sunset: json["sunset"] as num? ?? 0);
  }
}
