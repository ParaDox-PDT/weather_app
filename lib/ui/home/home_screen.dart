import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/models/weather/weather_model.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';
import 'package:flutter_defualt_project/data/network/api_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());
  bool isLoading=false;
  WeatherModel? weatherModel;

  _getData()async{
    setState(() {
      isLoading=true;
    });
    weatherModel = await apiRepository.getWeatherData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: isLoading? Center(
        child:CircularProgressIndicator(),
      ):Center(
        child: Text(weatherModel?.name ?? "",style: TextStyle(color: Colors.white),),
      )
    );
  }
}