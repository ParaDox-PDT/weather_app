import 'info_weather_model.dart';

class CurrentModel {
  final int dateTime;
  final int sunrise;
  final int sunset;
  final num temp;
  final num feelsLike;
  final int pressure;
  final int humidity;
  final num dewPoint;
  final num uvi;
  final num clouds;
  final int visibility;
  final num windSpeed;
  final num windDeg;
  final num windGust;
  final InfoWeatherModel infoWeatherModel;

  CurrentModel(
      {required this.dateTime,
      required this.sunrise,
      required this.sunset,
      required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.infoWeatherModel,
      required this.visibility,
      required this.humidity,
      required this.clouds,
      required this.dewPoint,
      required this.uvi,
      required this.windDeg,
      required this.windGust,
      required this.windSpeed});

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
        dateTime: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"],
        feelsLike: json["feels_like"],
        pressure: json["pressure"],
        infoWeatherModel: InfoWeatherModel.fromJson(json['weather'][0]),
        visibility: json["visibility"],
        humidity: json["humidity"],
        clouds: json["clouds"],
        dewPoint: json["dew_point"],
        uvi: json["uvi"],
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"],
        windSpeed: json["wind_speed"]);
  }
}
