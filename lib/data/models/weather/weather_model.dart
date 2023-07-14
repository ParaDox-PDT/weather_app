import 'coord_model.dart';
import 'current_weather_model.dart';
import 'main_model.dart';
import 'sys_model.dart';
import 'wind_model.dart';

class WeatherModel {
  final CoordModel coordModel;
  final CurrentWeatherModel currentWeatherModel;
  final String base;
  final MainModel mainModel;
  final num visibility;
  final WindModel windModel;
  final num clouds;
  final num dateTime;
  final SysModel sysModel;
  final num timezona;
  final num id;
  final String name;
  final num cod;

  WeatherModel(
      {required this.id,
      required this.sysModel,
      required this.windModel,
      required this.mainModel,
      required this.coordModel,
      required this.name,
      required this.visibility,
      required this.base,
      required this.clouds,
      required this.cod,
      required this.currentWeatherModel,
      required this.dateTime,
      required this.timezona});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        id: json["id"] as num? ?? 0,
        sysModel: SysModel.fromJson(json["sys"]),
        windModel: WindModel.fromJson(json["wind"]),
        mainModel: MainModel.fromJson(json["main"]),
        coordModel: CoordModel.fromJsom(json["coord"]),
        name: json["name"] as String? ?? "",
        visibility: json["visibility"] as num? ?? 0,
        base: json["base"] as String? ?? "",
        clouds: json["clouds"]["all"] as num? ?? 0 ,
        cod: json["cod"] as num? ?? 0,
        currentWeatherModel: CurrentWeatherModel.fromJson(json['weather'][0]),
        dateTime: json["dt"] as num? ?? 0,
        timezona: json["timezone"] as num? ?? 0);
  }
}
