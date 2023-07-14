import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/models/weather/weather_model.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';
import 'package:flutter_defualt_project/data/network/api_repository.dart';
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

  _getData() async {
    setState(() {
      isLoading = true;
    });
    weatherModel = await apiRepository.getWeatherData(region: "Toshkent");
    setState(() {
      if (weatherModel == null) {
        isIncorrectCity = true;
      }
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
        actions: [
          ZoomTapAnimation(
            onTap: () {},
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
                        "Incorrect city name!!!",textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.red,fontSize: 60),
                      ),
                    )
                  : Stack(
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
                          children: [
                            SizedBox(
                              height: 26.h,
                            ),
                            Text(
                              "Today, ${DateTime.fromMillisecondsSinceEpoch((weatherModel?.dateTime ?? 0) * 1000).toString().substring(0, 10)}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              weatherModel?.name ?? "",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              weatherModel?.sysModel.country ?? "",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            CachedNetworkImage(
                              imageUrl:
                                  "https://openweathermap.org/img/wn/${weatherModel?.currentWeatherModel.icon}@2x.png",
                            ),
                            Text(
                              "${(weatherModel!.mainModel.temp - 273.15).toString().substring(0, 2)}°C",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            SizedBox(
                              height: 80.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "${weatherModel?.currentWeatherModel.main}, ${weatherModel?.currentWeatherModel.description}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 26.sp))
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Wind status",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
                        )
                      ],
                    ),
            ),
    );
  }
}
