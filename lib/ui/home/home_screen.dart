import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/local/storage_repository/storage_repository.dart';
import 'package:flutter_defualt_project/data/models/weather/weather_model.dart';
import 'package:flutter_defualt_project/data/models/weather_daily_hourly/daily_item/daily_item_model.dart';
import 'package:flutter_defualt_project/data/models/weather_daily_hourly/hourly_item/hourly_item_model.dart';
import 'package:flutter_defualt_project/data/models/weather_daily_hourly/weather_model_daily_hourly.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';
import 'package:flutter_defualt_project/data/network/api_repository.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_defualt_project/ui/home/widgets/daily_item.dart';
import 'package:flutter_defualt_project/ui/home/widgets/hourly_item.dart';
import 'package:flutter_defualt_project/utils/colors.dart';
import 'package:flutter_defualt_project/utils/icons.dart';
import 'package:flutter_defualt_project/utils/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());
  bool isLoading = false;
  bool isIncorrectCity = false;
  WeatherModel? weatherModel;
  WeatherModelAllTime? weatherModelAllTime;
  TextEditingController controller = TextEditingController();
  String? region = StorageRepository.getString("region");
  List<DailyItemModel>? days = [];
  List<HourlyItemModel>? hours = [];
  num latt=0;
  num longg=0;

  _getHourlyData({
    required num lat,
    required num long,
  }) async {
    setState(() {
      isLoading = true;
    });

    weatherModelAllTime =
        await apiRepository.getHourlyData(lat: lat, long: long);
    days = weatherModelAllTime!.daily;
    hours = weatherModelAllTime!.hourly;
    setState(() {
      if (weatherModel == null) {
        isIncorrectCity = true;
      }
      isLoading = false;
    });
  }

  _getDataByLatLong({
    required num lat,
    required num long,
  }) async {
    setState(() {
      isLoading = true;
    });

    weatherModel =
        await apiRepository.getWeatherDataByLatLong(lat: lat, long: long);
    setState(() {
      if (weatherModel == null) {
        isIncorrectCity = true;
      }
      isLoading = false;
    });
  }

  _getData(String searchRegion) async {
    setState(() {
      isLoading = true;
    });
    weatherModel =
        await apiRepository.getWeatherDataByQuery(region: searchRegion);
    latt=weatherModel!.coordModel.lat;
    latt=weatherModel!.coordModel.lon;

    setState(() {
      if (weatherModel == null) {
        isIncorrectCity = true;
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getData("Tashkent");
    _getHourlyData(lat: latt, long: longg);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          ZoomTapAnimation(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.searchScreen,
                  arguments: () {
                _getData(StorageRepository.getString("region"));
                setState(() {});
              });
            },
            child: SvgPicture.asset(AppIcons.search),
          ),
          SizedBox(
            width: 26.w,
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.C_30A2C5,
                    AppColors.C_00242F,
                  ],
                ),
              ),
              child: isIncorrectCity
                  ? Center(
                      child: Text(
                        "Incorrect city name!!!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.red, fontSize: 60),
                      ),
                    )
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: 130.h,
                                    child: Image.asset(
                                      AppImages.backgroundImg,
                                      width: 240.w,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 26.h,
                                      ),
                                      Text(
                                        "Today, ${DateTime.fromMillisecondsSinceEpoch((weatherModel?.dateTime ?? 0) * 1000).toString().substring(0, 10)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        weatherModel?.name ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Text(
                                        weatherModel?.sysModel.country ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      SizedBox(
                                        height: 110.h,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://openweathermap.org/img/wn/${weatherModel?.currentWeatherModel.icon}@2x.png",
                                        ),
                                      ),
                                      Text(
                                        "${(weatherModel!.mainModel.temp - 273.15).toString().substring(0, 2)}°C",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      SizedBox(
                                        height: 80.h,
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${weatherModel?.currentWeatherModel.main}, ${weatherModel?.currentWeatherModel.description}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 26.sp))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Wind status",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Text(
                                                      "${weatherModel?.windModel.speed} mph",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Text(
                                                      "${weatherModel?.windModel.deg} degree",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Text(
                                                      "Humidity",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Text(
                                                      "${weatherModel?.mainModel.humidity} %",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Visibility",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Text(
                                                      "${weatherModel!.visibility / 1000} km",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Text(
                                                      "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Text(
                                                      "Air pressure",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Text(
                                                      "${weatherModel?.mainModel.pressure} mb",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 260.h,
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(60.r),
                                topLeft: Radius.circular(
                                  60.r,
                                ),
                              ),
                              color: AppColors.white),
                          height: 250.h,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 30.h, left: 20.w, right: 20.w),
                            child: Expanded(
                              child: ListView(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "The Next 8 days",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: AppColors.black),
                                      ),
                                      SizedBox(height: 16.h,),
                                      SizedBox(
                                        height: 100.h,
                                        child: Expanded(
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              ...List.generate(
                                                  days!.length,
                                                      (index) => DailyDataItem(
                                                      img: days![index].weather[0].icon,
                                                      temp: days![index].tempModel.day,
                                                      day: DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                          (days![index]
                                                              .dateTime) *
                                                              1000)
                                                          .weekday
                                                          .toString()))
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Text(
                                        "The Next 49 hours",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: AppColors.black),
                                      ),
                                      SizedBox(height: 16.h,),
                                      SizedBox(
                                        height: 100.h,
                                        child: Expanded(
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              ...List.generate(
                                                  hours!.length,
                                                      (index) => HourlyItem(
                                                      icon: hours![index].weather[0].icon,
                                                      temp: hours![index].temp,
                                                      hour: hours![index]
                                                          .dateTime))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
    );
  }
}
