import 'package:chatapp/model/models_model.dart';
import 'package:chatapp/services/api_service.dart';
import 'package:flutter/material.dart';

class ProviderModels with ChangeNotifier {
  List<Models> modelList = [];

  String currentModel = "gpt-3.5-turbo";

  List<Models> get getModelList {
    return modelList;
  }

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String model) {
    currentModel = model;
    notifyListeners();
  }

  Future<List<Models>> getAllModels() async {
    modelList = await ApiServices.getModels();
    return modelList;
  }
}
