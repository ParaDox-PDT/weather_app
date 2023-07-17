import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/models/weather/weather_model.dart';
import 'package:flutter_defualt_project/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/universal_response.dart';
import '../models/weather_daily_hourly/weather_model_daily_hourly.dart';
import 'network_utils.dart';

class ApiProvider {
  Future<UniversalResponse> getHourlyData({
    required num lat,
    required num long,
  }) async {
    Uri uri = Uri.https(baseUrlWithoutHttp, "/data/2.5/onecall", {
      "appid": apiKeyForHourly,
      "lat": lat.toString(),
      "lon": long.toString(),
      "exclude": "minutely,current",
      "units": "metric",
    });

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: WeatherModelAllTime.fromJson(
            jsonDecode(response.body),
          ),
        );
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalResponse(error: "Internet Error!");
    } on FormatException {
      return UniversalResponse(error: "Format Error!");
    } catch (err) {
      debugPrint("ERROR:$err. ERROR TYPE: ${err.runtimeType}");
      return UniversalResponse(error: err.toString());
    }
  }

  Future<UniversalResponse> getCurrentDayDataByLatlon({
    required num lat,
    required num long,
  }) async {
    // Uri uri = Uri.parse("$baseUrl/data/2.5/weather?appid=$apiKey&q=$region");
    Uri uri = Uri.https(baseUrlWithoutHttp, "/data/2.5/weather", {
      "appid": apiKey,
      "lat": lat.toString(),
      "lon": long.toString(),
    });
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          statusCode: response.statusCode,
          data: WeatherModel.fromJson(
            jsonDecode(response.body),
          ),
        );
      }

      return handleHttpErrors(response);
    } on SocketException {
      return UniversalResponse(error: "Internet Error!");
    } on FormatException {
      return UniversalResponse(error: "Format Error!");
    }
    // on TypeError{
    //   return UniversalData(error: "TYPE ERROR");
    // }
    catch (err) {
      print("ERROR: $err");
      return UniversalResponse(error: err.toString());
    }
  }

  Future<UniversalResponse> getCurrentDayDataByQuery(String region) async {
    // Uri uri = Uri.parse("$baseUrl/data/2.5/weather?appid=$apiKey&q=$region");
    Uri uri = Uri.https(baseUrlWithoutHttp, "/data/2.5/weather", {
      "appid": apiKey,
      "q": region,
    });
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          statusCode: response.statusCode,
          data: WeatherModel.fromJson(
            jsonDecode(response.body),
          ),
        );
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalResponse(error: "Internet Error!");
    } on FormatException {
      return UniversalResponse(error: "Format Error!");
    }
    // on TypeError{
    //   return UniversalData(error: "TYPE ERROR");
    // }
    catch (err) {
      return UniversalResponse(error: err.toString());
    }
  }
}
