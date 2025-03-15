import 'dart:convert' show json;

import 'package:chat/core/config/env.dart';
import 'package:chat/models/ollama_model_info.dart';
import 'package:chat/models/settings_model.dart' show SettingsModel;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http show get;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier {
  late SettingsModel _settings;
  List<OllamaModelInfo> _models = [];

  SettingsModel get settings => _settings;
  List<OllamaModelInfo> get models => _models;

  SettingsViewModel() {
    _settings = SettingsModel(isDarkMode: false, notificationsEnabled: true, language: '中文');
    loadSettings();
    fetchModels(); // Load model list
  }

  // 加载设置
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _settings = SettingsModel.fromJson({
      'isDarkMode': prefs.getBool('isDarkMode') ?? false,
      'notificationsEnabled': prefs.getBool('notificationsEnabled') ?? true,
      'language': prefs.getString('language') ?? '中文',
    });
    notifyListeners();
  }

  // 切换主题
  void toggleDarkMode(bool value) {
    _settings.isDarkMode = value;
    saveSettings();
    notifyListeners();
  }

  // 切换通知
  void toggleNotifications(bool value) {
    _settings.notificationsEnabled = value;
    saveSettings();
    notifyListeners();
  }

  // 切换语言
  void setLanguage(String value) {
    _settings.language = value;
    saveSettings();
    notifyListeners();
  }

  // Save Settings
  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _settings.isDarkMode);
    prefs.setBool('notificationsEnabled', _settings.notificationsEnabled);
    prefs.setString('language', _settings.language);
    prefs.setString('selectedModel', _settings.selectedModel!);
  }

  Future<void> fetchModels() async {
    try {
      final response = await http.get(Uri.parse(Env.apiModelList));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // 检查是否是Map并提取内部的List
        List<dynamic> jsonData = data is Map<String, dynamic> && data.containsKey('models') ? data['models'] : data;
        // 转换为List<ModelInfo>
        _models = jsonData.map<OllamaModelInfo>((e) => OllamaModelInfo.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('加载模型列表失败');
      }
    } catch (e) {
      _models = [];
      notifyListeners();
    }
  }

  void setSelectedModel(String modelName) {
    _settings.selectedModel = modelName;
    saveSettings();
    notifyListeners();
  }
}
