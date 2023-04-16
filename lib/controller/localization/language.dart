import 'package:chatapp/constants/apptheme.dart';
import 'package:chatapp/services/myservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale? language;

  ThemeData appTheme = themeEnglish;

  MyServices myServices = Get.find();

  changeLang(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedprefs.setString("lang", langCode);
    appTheme = langCode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? langShared = myServices.sharedprefs.getString("lang");
    if (langShared == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else if (langShared == "en") {
      appTheme = themeEnglish;
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
