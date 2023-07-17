import 'daily_item/daily_item_model.dart';
import 'hourly_item/hourly_item_model.dart';

class WeatherModelAllTime {
  final num lat;
  final num lon;
  final String timezone;
  final num timezoneOffset;
  final List<HourlyItemModel> hourly;
  final List<DailyItemModel> daily;

  WeatherModelAllTime(
      {required this.lat,
      required this.lon,
      required this.timezone,
      required this.timezoneOffset,
      required this.hourly,
      required this.daily});

  factory WeatherModelAllTime.fromJson(Map<String, dynamic> json) {
    return WeatherModelAllTime(
      lat: json["lat"],
      lon: json["lon"],
      timezone: json["timezone"],
      timezoneOffset: json["timezone_offset"],
      hourly: (json['hourly'] as List<dynamic>?)
              ?.map((e) => HourlyItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      daily: (json['daily'] as List<dynamic>?)
              ?.map((e) => DailyItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
