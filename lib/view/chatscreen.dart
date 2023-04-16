import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/controller/chat_provider.dart';
import 'package:chatapp/controller/provider.dart';
import 'package:chatapp/services/assets.dart';
import 'package:chatapp/services/services.dart';
import 'package:chatapp/view/widget/chatwidget.dart';
import 'package:chatapp/view/widget/customdialog.dart';
import 'package:chatapp/view/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _istyping = false;
  late TextEditingController text;
  late ScrollController scrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    text = TextEditingController();
    focusNode = FocusNode();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    text.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  //List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final providerModels = Provider.of<ProviderModels>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: const Text("ArnousGPT"),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                showGeneralDialog(
                  barrierDismissible: false,
                  context: context,
                  barrierColor: Colors.black54, // space around dialog
                  transitionDuration: const Duration(milliseconds: 800),
                  transitionBuilder: (context, a1, a2, child) {
                    return ScaleTransition(
                      scale: CurvedAnimation(
                          parent: a1,
                          curve: Curves.elasticOut,
                          reverseCurve: Curves.easeOutCubic),
                      child: CustomDialog(
                        // our custom dialog
                        title: "5".tr,
                        content: "${"4".tr}\n \n Developed by Mohamed Arnous",
                        positiveBtnText: "6".tr,
                        positiveBtnPressed: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                  pageBuilder: (BuildContext context, Animation animation,
                      Animation secondaryAnimation) {
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      color: Colors.orange,
                    );
                  },
                );
              },
              child: Image.asset(
                AssetsManger.openAILogo,
              )),
          actions: [
            IconButton(
                onPressed: () async {
                  await Services.showModelSheet(context: context);
                },
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatProvider.getChatList.length, //chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                        msg: chatProvider
                            .getChatList[index].msg, //chatList[index].msg,
                        chatIndex: chatProvider.getChatList[index]
                            .chatIndex //chatList[index].chatIndex,
                        );
                  },
                ),
              ),
              if (_istyping) ...[
                const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 18,
                ),
              ],
              const SizedBox(height: 15),
              Material(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            focusNode: focusNode,
                            style: const TextStyle(color: Colors.white),
                            controller: text,
                            onSubmitted: (value) async {
                              await sendMessage(
                                  providerModels: providerModels,
                                  chatProvider: chatProvider);
                            },
                            decoration: InputDecoration(
                              hintText: "3".tr,
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await sendMessage(
                              providerModels: providerModels,
                              chatProvider: chatProvider);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void scrollListToEnd() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.easeInOut);
  }

  Future<void> sendMessage(
      {required ProviderModels providerModels,
      required ChatProvider chatProvider}) async {
    if (_istyping) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: TextWidget(label: "You Can't multiple messages at a time")));
      return;
    }
    if (text.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: TextWidget(label: "Please Type A Message")));
      return;
    }
    try {
      String msg = text.text;
      setState(() {
        _istyping = true;
        // chatList.add(ChatModel(msg: text.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        text.clear();
        focusNode.unfocus();
      });
      debugPrint("request");
      await chatProvider.getMessageAnswer(
          msg: msg, chosenModelID: providerModels.currentModel);
      /*  chatList.addAll(await ApiServices.sendMessage(
          modelId: providerModels.currentModel, msg: text.text)); */
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: TextWidget(label: error.toString())));
    } finally {
      setState(() {
        scrollListToEnd();
        _istyping = false;
      });
    }
  }
}
