class InfoWeatherModel {
  final num id;
  final String main;
  final String description;
  final String icon;

  InfoWeatherModel(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory InfoWeatherModel.fromJson(Map<String, dynamic> json) {
    return InfoWeatherModel(
        id: json["id"] as num? ?? 0,
        main: json["main"] as String? ?? "",
        description: json["description"] as String? ?? "",
        icon: json["icon"] as String? ?? "");
  }
}
