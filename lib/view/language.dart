import 'package:chatapp/controller/localization/language.dart';
import 'package:chatapp/view/chatscreen.dart';
import 'package:chatapp/view/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends GetView<LocalController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      // padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "1".tr,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButtonLang(
              textbutton: "Ar",
              onPressed: () {
                controller.changeLang("ar");
                Get.offAll(const ChatScreen());
              }),
          CustomButtonLang(
              textbutton: "En",
              onPressed: () {
                controller.changeLang("en");
                Get.offAll(const ChatScreen());
              }),
        ],
      ),
    ));
  }
}
