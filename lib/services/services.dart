import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/view/widget/dropdown.dart';
import 'package:chatapp/view/widget/textwidget.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showModelSheet({required BuildContext context}) async {
    showModalBottomSheet(
      backgroundColor: scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: 110,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                        child: TextWidget(
                      label: "Choosen Model: ",
                      fontSize: 15,
                    )),
                    Flexible(flex: 2, child: DropDownWidget())
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: logoColor,
                        onPressed: () {},
                        child: const Text(
                          "Settings",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
