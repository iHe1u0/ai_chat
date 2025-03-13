import 'package:flutter/material.dart';

class OllamaModelInfo {
  final String name;
  final String size;
  final String parameterSize;
  final String quantizationLevel;

  OllamaModelInfo({
    required this.name,
    required this.size,
    required this.parameterSize,
    required this.quantizationLevel,
  });

  factory OllamaModelInfo.fromJson(Map<String, dynamic> json) {
    debugPrint("$json");
    return OllamaModelInfo(
      name: json['name'],
      size: (json['size'] / (1024 * 1024 * 1024)).toStringAsFixed(1) + ' GB',
      parameterSize: json['details']['parameter_size'],
      quantizationLevel: json['details']['quantization_level'],
    );
  }
}
