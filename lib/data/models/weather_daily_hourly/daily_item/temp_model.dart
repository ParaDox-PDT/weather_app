class TempModel {
  final num day;
  final num min;
  final num max;
  final num night;
  final num eve;
  final num morn;

  TempModel(
      {required this.day,
      required this.min,
      required this.eve,
      required this.max,
      required this.morn,
      required this.night});

  factory TempModel.fromJson(Map<String, dynamic> json) {
    return TempModel(
        day: json["day"] as num? ?? 0,
        min: json["min"] as num? ?? 0,
        eve: json["eve"] as num? ?? 0,
        max: json["max"] as num? ?? 0,
        morn: json["morn"] as num? ?? 0,
        night: json["night"] as num? ?? 0 );
  }
}
