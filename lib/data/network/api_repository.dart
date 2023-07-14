import 'package:flutter_defualt_project/data/models/weather/weather_model.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';

import '../models/universal_response.dart';

class ApiRepository{
  final ApiProvider apiProvider;
  ApiRepository({required this.apiProvider});

  Future<List<WeatherModel>> fetchDefaultModelData()async{
    UniversalResponse universalResponse=await apiProvider.getAllData();
    if(universalResponse.error.isEmpty){
      return universalResponse.data as  List<WeatherModel>;
    }
    return [];
  }
}