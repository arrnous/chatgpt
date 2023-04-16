import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:chatapp/constants/api_link.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/model/models_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<Models>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonError ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      //   print("jsonresponse $jsonResponse");

      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        // print("temp ${value["id"]}");
      }
      return Models.modelFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // send message function
  static Future<List<ChatModel>> sendMessage(
      {required String msg, required String modelId}) async {
    try {
      log("model $modelId");
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $API_KEY',
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": msg,
              }
            ]
          },
        ),
      );

      //  Map jsonResponse = jsonDecode(response.body);
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        // print("jsonError ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        //  debugPrint("response choices ${jsonResponse['choices'][0]['text']}");
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("send error $error");
      rethrow;
    }
  }
}
