class FeelsLikeModel {
  final num day;
  final num night;
  final num eve;
  final num morn;

  FeelsLikeModel(
      {required this.day,
      required this.night,
      required this.eve,
      required this.morn});

  factory FeelsLikeModel.fromJson(Map<String, dynamic> json) {
    return FeelsLikeModel(
        day: json["day"] as num? ?? 0,
        eve: json["eve"] as num? ?? 0,
        morn: json["morn"] as num? ?? 0,
        night: json["night"] as num? ?? 0);
  }
}
