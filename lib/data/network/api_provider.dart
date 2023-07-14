import 'dart:convert';


import 'package:flutter_defualt_project/data/models/weather/weather_model.dart';
import 'package:flutter_defualt_project/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/universal_response.dart';

class ApiProvider {
  Future<UniversalResponse> getAllData() async {
    Uri uri = Uri.parse("$baseUrl/data/2.5/weather?appid=$apiKey&q=Tashkent");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body) as List?)?.map((e) =>
                WeatherModel.fromJson(e)).toList() ?? []);
      }
      return UniversalResponse(error: "ERROR");
    }catch (error){
      return UniversalResponse(error: error.toString());
    }
  }
}