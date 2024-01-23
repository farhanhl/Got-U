import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:got_u_app/app/core/providers/api.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/home_controller.dart';
import '../services/home_service.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(
        HomeService(
          Get.find<Api>(),
        ),
      ),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.isBackButton) {
              return true;
            } else {
              return false;
            }
          },
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => controller.changeTheme(),
              child: FaIcon(
                Get.isDarkMode ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                color: Get.isDarkMode ? darkPrimary : lightPrimary,
              ),
            ),
            body: DoubleBackToCloseApp(
              snackBar: SnackBar(
                content: const Text(
                  "Tap again to exit",
                ),
                backgroundColor: Get.isDarkMode ? lightPrimary : darkPrimary,
              ),
              child: SafeArea(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(16.sp),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Get.isDarkMode ? lightSecondary : darkSecondary,
                            Get.isDarkMode ? lightPrimary : darkPrimary,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            controller.getGreeting(),
                            style: TextStyle(
                              fontSize: 32.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Get.isDarkMode ? darkPrimary : lightPrimary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: controller.isLoading
                                ? const SizedBox.shrink()
                                : Text(
                                    controller.quotesModel.content ?? "-",
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Get.isDarkMode
                                          ? darkPrimary
                                          : lightPrimary,
                                    ),
                                  ),
                          ),
                          controller.isLoading
                              ? const SizedBox.shrink()
                              : Text(
                                  "- ${controller.quotesModel.author ?? ''}",
                                  maxLines: 4,
                                  style: TextStyle(
                                    color: Get.isDarkMode
                                        ? darkPrimary
                                        : lightPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Get.isDarkMode ? lightSecondary : darkSecondary,
                            Get.isDarkMode ? lightPrimary : darkPrimary,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(12.sp),
                      child: Text(
                        "Your IP: ${controller.ipifyModel.ip ?? '-'}",
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Get.isDarkMode ? darkPrimary : lightPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: controller.ipFieldController,
                      decoration: InputDecoration(
                        hintText: "IP Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                            width: 2.w,
                            color: Get.isDarkMode ? lightPrimary : darkPrimary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                            width: 2.w,
                            color: Get.isDarkMode ? lightPrimary : darkPrimary,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                            width: 2.w,
                            color: Get.isDarkMode ? lightPrimary : darkPrimary,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                            width: 1.w,
                            color: errorColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 10.h,
                        ),
                        hintStyle: TextStyle(
                          color: Get.isDarkMode ? lightPrimary : darkPrimary,
                        ),
                        suffixIcon: controller.ipFieldController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                ),
                                onPressed: () {
                                  controller.ipFieldController.clear();
                                  controller.update();
                                },
                              )
                            : const SizedBox.shrink(),
                        filled: true,
                        fillColor: Get.isDarkMode ? darkPrimary : lightPrimary,
                      ),
                      onChanged: (value) {
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      onPressed: () => controller.getIpData(
                        controller.ipFieldController.text,
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Get.isDarkMode ? darkColor : lightPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
