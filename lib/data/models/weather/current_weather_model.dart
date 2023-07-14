class CurrentWeatherModel {
  final num id;
  final String main;
  final String description;
  final String icon;

  CurrentWeatherModel(
      {required this.id,
      required this.description,
      required this.icon,
      required this.main});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
        id: json["id"] as num? ?? 0,
        description: json["description"] as String? ?? "",
        icon: json["icon"] as String? ?? "",
        main: json["main"] as String? ?? "");
  }
}
