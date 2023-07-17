import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class DailyDataItem extends StatelessWidget {
  const DailyDataItem({super.key, required this.img, required this.temp, required this.day});
  final String img;
  final num temp;
  final String day;

  static String getWeekDayName(String day){
    switch(day){
      case "1":
        return "Monday";
      case "2":
        return "Tuesday";
      case "3":
        return "Wednesday";
      case "4":
        return "Thursday";
      case "5":
        return "Friday";
      case "6":
        return "Saturday";
      case "7":
        return "Sunday";
      default:
        return "Error date";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Text(
            getWeekDayName(day),
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColors.black),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 75.h,
            width: 70.w,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(20.r),
              border: Border.all(
                  width: 1.w,
                  color: AppColors.C_D4D4D4),
            ),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl:
                  "https://openweathermap.org/img/wn/$img@2x.png",
                  height: 52.h,
                  fit: BoxFit.fitHeight,
                ),
                Text(
                  "${temp.toString().substring(0,2)}°C",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(
                      color: AppColors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
