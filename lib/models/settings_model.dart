class SettingsModel {
  bool isDarkMode;
  bool notificationsEnabled;
  String language;
  String? selectedModel; // 新增选中模型字段

  SettingsModel({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.language,
    this.selectedModel,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkMode: json['isDarkMode'] ?? false,
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      language: json['language'] ?? '中文',
      selectedModel: json['selectedModel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'notificationsEnabled': notificationsEnabled,
      'language': language,
      'selectedModel': selectedModel,
    };
  }
}
