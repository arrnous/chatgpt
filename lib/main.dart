import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/controller/chat_provider.dart';
import 'package:chatapp/controller/localization/language.dart';
import 'package:chatapp/controller/localization/translate.dart';
import 'package:chatapp/controller/provider.dart';
import 'package:chatapp/services/myservices.dart';
import 'package:chatapp/view/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderModels(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        )
      ],
      child: GetMaterialApp(
          locale: controller.language,
          translations: MyTranslation(),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(
                color: cardColor,
              )),
          home: const Language()),
    );
  }
}
