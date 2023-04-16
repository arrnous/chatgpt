import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/services/assets.dart';
import 'package:chatapp/view/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatIndex == 0
                    ? Image.asset(
                        AssetsManger.userImage,
                        height: 30,
                        width: 30,
                      )
                    : Lottie.asset(AssetsManger.botLottie,
                        repeat: false, height: 30, width: 30),
                const SizedBox(width: 10),
                Expanded(
                    child: chatIndex == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextWidget(label: msg),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      msg.trim(),
                                    )
                                  ]),
                            ),
                          )),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
