import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class HourlyItem extends StatelessWidget {
  const HourlyItem({super.key, required this.hour, required this.icon, required this.temp});
  final int hour;
  final String icon;
  final num temp;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Text(
            "${DateTime.fromMillisecondsSinceEpoch(hour * 1000).toString().substring(11,16)}",
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
                  "https://openweathermap.org/img/wn/$icon@2x.png",
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
