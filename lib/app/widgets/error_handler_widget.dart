import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:got_u_app/app/core/theme/app_theme.dart';
import 'package:lottie/lottie.dart';

class ErrorHandlerWidget {
  static errorDialog({
    required VoidCallback onPressedButton,
    String title = "Oops..",
    String message = "Something Went Wrong",
    VoidCallback? onPressedBackButton,
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      backgroundColor: Get.isDarkMode ? lightPrimary : darkPrimary,
      contentPadding: EdgeInsets.all(8.sp),
      content: Column(
        children: [
          Lottie.asset(
            "assets/lotties/error_animation.json",
            height: 150.h,
            width: 150.w,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              color: Get.isDarkMode ? darkPrimary : lightPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            message,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode ? darkPrimary : lightPrimary,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onPressedButton,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                      Get.isDarkMode ? darkPrimary : lightPrimary,
                    ),
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      color: Get.isDarkMode ? lightPrimary : darkPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
