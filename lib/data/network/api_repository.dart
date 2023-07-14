import 'package:flutter_defualt_project/data/models/weather/weather_model.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';

import '../models/universal_response.dart';

class ApiRepository{
  final ApiProvider apiProvider;
  ApiRepository({required this.apiProvider});

  Future<WeatherModel?> getWeatherData({required String region})async{
    UniversalResponse universalResponse=await apiProvider.getAllData(region);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as  WeatherModel;
    }
    return null;
  }
}