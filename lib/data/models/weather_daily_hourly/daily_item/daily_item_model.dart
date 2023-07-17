import 'package:flutter_defualt_project/data/models/weather_daily_hourly/daily_item/feels_like_model.dart';
import 'package:flutter_defualt_project/data/models/weather_daily_hourly/daily_item/temp_model.dart';

import '../info_weather_model.dart';

class DailyItemModel {
  final int dateTime;
  final num sunrise;
  final num sunset;
  final num moonrise;
  final num moonset;
  final num moonPhase;
  final num pressure;
  final num humidity;
  final num dewPoint;
  final num uvi;
  final num clouds;
  final num windSpeed;
  final num windDeg;
  final num windGust;
  final num pop;
  final TempModel tempModel;
  final FeelsLikeModel feelsLikeModel;
  final List<InfoWeatherModel> weather;

  DailyItemModel(
      {required this.dateTime,
      required this.sunrise,
      required this.feelsLikeModel,
      required this.tempModel,
      required this.pop,
      required this.humidity,
      required this.clouds,
      required this.dewPoint,
      required this.uvi,
      required this.windDeg,
      required this.windGust,
      required this.windSpeed,
      required this.pressure,
      required this.sunset,
      required this.moonPhase,
      required this.moonrise,
      required this.moonset,
      required this.weather});

  factory DailyItemModel.fromJson(Map<String, dynamic> json) {
    return DailyItemModel(
        dateTime: json["dt"] as int? ?? 0,
        sunrise: json["sunrise"],
        feelsLikeModel: FeelsLikeModel.fromJson(json['feels_like'] as Map<String, dynamic>),
        tempModel: TempModel.fromJson(json['temp'] as Map<String, dynamic>),
        pop: json["pop"] as num? ?? 0,
        humidity: json["humidity"] as num? ?? 0,
        clouds: json["clouds"] as num? ?? 0,
        dewPoint: json["dew_point"]as num? ?? 0,
        uvi: json["uvi"]as num? ?? 0,
        windDeg: json["wind_deg"]as num? ?? 0,
        windGust: json["wind_gust"]as num? ?? 0,
        windSpeed: json["wind_speed"]as num? ?? 0,
        pressure: json["pressure"]as num? ?? 0,
        sunset: json["sunset"]as num? ?? 0,
        moonPhase: json["moon_phase"]as num? ?? 0,
        moonrise: json["moonrise"]as num? ?? 0,
        moonset: json["moonset"]as num? ?? 0,
        weather: (json["weather"] as List<dynamic>?)
            ?.map(
                (e) => InfoWeatherModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
            []);
  }
}
