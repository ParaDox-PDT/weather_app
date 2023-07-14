class MainModel {
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final num humidity;

  MainModel(
      {required this.feelsLike,
      required this.humidity,
      required this.tempMax,
      required this.temp,
      required this.pressure,
      required this.tempMin});

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
        feelsLike: json["feels_like"] as num? ?? 0,
        humidity: json["humidity"] as num? ?? 0,
        tempMax: json["temp_max"] as num? ?? 0,
        temp: json["temp"] as num? ?? 0,
        pressure: json["pressure"] as num? ?? 0,
        tempMin: json["temp_min"] as num? ?? 0);
  }
}
