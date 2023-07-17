import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/local/storage_repository/storage_repository.dart';
import 'package:flutter_defualt_project/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onSearchTap});

  final VoidCallback onSearchTap;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: AppColors.C_EDEDED),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  hintText: "Search Location",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(width: 1, color: AppColors.C_EDEDED)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(width: 1, color: AppColors.C_EDEDED)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(width: 1, color: AppColors.C_EDEDED)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(width: 1, color: AppColors.C_EDEDED)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide:
                          const BorderSide(width: 1, color: AppColors.C_EDEDED)),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Spacer(),
            ZoomTapAnimation(
              onTap: () {
                StorageRepository.putString("region", controller.text);
                widget.onSearchTap.call();
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: Colors.blue,
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                child: Center(
                    child: Text(
                  "Apply",
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
