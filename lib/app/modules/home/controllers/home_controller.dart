import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:got_u_app/app/data/models/ipify_model.dart';
import 'package:got_u_app/app/widgets/error_handler_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/ip_info_model.dart';
import '../../../data/models/quotes_model.dart';
import '../services/home_service.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  HomeService services;
  HomeController(this.services);
  DateTime now = DateTime.now();
  TextEditingController ipFieldController = TextEditingController();
  QuotesModel quotesModel = QuotesModel();
  IpInfo ipInfoModel = IpInfo();
  bool isBackButton = false;
  bool isLoading = false;
  IpifyModel ipifyModel = IpifyModel();

  String getGreeting() {
    int hour = now.hour;

    if (hour >= 4 && hour < 12) {
      return 'Good morning!';
    } else if (hour >= 12 && hour < 20) {
      return 'Good afternoon!';
    } else {
      return 'Good night!';
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getQuotesData();
    await getIpAddress();
  }

  Future<void> getQuotesData() async {
    isLoading = true;
    services.getQuotesData().then((value) {
      isLoading = false;
      quotesModel = value;
      update();
    }).catchError(
      (e) {
        isLoading = false;
      },
    );
  }

  Future<void> getIpAddress() async {
    isLoading = true;
    services.getIpAddress().then((value) {
      isLoading = false;
      ipifyModel.ip = value;
      update();
    }).catchError(
      (e) {
        isLoading = false;
      },
    );
  }

  Future<void> getIpData(String ip) async {
    if (ip.isEmpty) {
      Get.snackbar(
        "Notification",
        "Please fill the form",
        backgroundColor: errorColor,
        colorText: lightColor,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      submitForm();
      await services.getIpData(ip).then((value) {
        ipInfoModel = value;
        final Uri googleMapsUrl = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${ipInfoModel.loc}',
        );
        Get.defaultDialog(
          contentPadding: EdgeInsets.all(8.sp),
          title: "Result",
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset(
                "assets/lotties/animation.json",
                height: 180.h,
                width: 180.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: Get.width.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_city,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        "City: ${ipInfoModel.city}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              SizedBox(
                width: Get.width.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.flag,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        "Country: ${ipInfoModel.country}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              SizedBox(
                width: Get.width.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.flag,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        "Region: ${ipInfoModel.region}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              SizedBox(
                width: Get.width.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_city,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        "Coordinate: ${ipInfoModel.loc}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              SizedBox(
                width: Get.width.w, // Set a width here or use another value
                child: Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        "Org: ${ipInfoModel.org}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              SizedBox(
                width: Get.width.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        "Timezone: ${ipInfoModel.timezone}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => openMaps(googleMapsUrl),
                      child: Text(
                        "Open Google Maps",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Get.isDarkMode ? darkColor : lightPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Close",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Get.isDarkMode ? darkColor : lightPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        finishSubmit();
        update();
      }).catchError(
        (e) {
          finishSubmit();
          ErrorHandlerWidget.errorDialog(
            onPressedButton: () {
              Get.back();
            },
          );
        },
      );
    }
  }

  Future<void> openMaps(Uri googleMapsUrl) async {
    if (!await launchUrl(googleMapsUrl)) {
      throw Exception('Could not launch $googleMapsUrl');
    }
  }

  void submitForm() {
    isBackButton = false;
    EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    FocusManager.instance.primaryFocus?.unfocus();
    update();
  }

  void finishSubmit() {
    isBackButton = true;
    EasyLoading.dismiss();
    update();
  }

  void changeTheme() {
    Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
    Future.delayed(const Duration(milliseconds: 200), () {
      if (Get.isDarkMode) {
        box.write("isDarkMode", true);
      } else {
        box.remove("isDarkMode");
      }
      update();
    });
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
