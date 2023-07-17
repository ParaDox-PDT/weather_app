import '../info_weather_model.dart';

class HourlyItemModel {
  final int dateTime;
  final num temp;
  final num feelsLike;
  final num pressure;
  final num humidity;
  final num dewPoint;
  final num uvi;
  final num clouds;
  final num visibility;
  final num windSpeed;
  final num windDeg;
  final num windGust;
  final List<InfoWeatherModel> weather;
  final num pop;

  HourlyItemModel(
      {required this.dateTime,
      required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.windSpeed,
      required this.windGust,
      required this.windDeg,
      required this.uvi,
      required this.dewPoint,
      required this.clouds,
      required this.humidity,
      required this.visibility,
      required this.pop,
      required this.weather});

  factory HourlyItemModel.fromJson(Map<String, dynamic> json) {
    return HourlyItemModel(
        dateTime: json["dt"] as int? ?? 0,
        temp: json["temp"]  as num? ?? 0 ,
        feelsLike: json["feels_like"] as num? ?? 0,
        pressure: json["pressure"] as num? ?? 0,
        windSpeed: json["wind_speed"] as num? ?? 0,
        windGust: json["wind_gust"] as num? ?? 0,
        windDeg: json["wind_deg"] as num? ?? 0,
        uvi: json["uvi"] as num? ?? 0,
        dewPoint: json["dew_point"] as num? ?? 0,
        clouds: json["clouds"] as num? ?? 0,
        humidity: json["humidity"] as num? ?? 0,
        visibility: json["visibility"] as num? ?? 0,
        pop: json["pop"] as num? ?? 0,
        weather: (json["weather"] as List<dynamic>?)
                ?.map(
                    (e) => InfoWeatherModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            []);
  }
}
