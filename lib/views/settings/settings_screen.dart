import 'package:chat/viewmodels/settings_viewmodel.dart' show SettingsViewModel;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('深色模式'),
            trailing: Switch(
              value: viewModel.settings.isDarkMode,
              onChanged: (value) => viewModel.toggleDarkMode(value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('通知'),
            trailing: Switch(
              value: viewModel.settings.notificationsEnabled,
              onChanged: (value) => viewModel.toggleNotifications(value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('语言'),
            trailing: DropdownButton<String>(
              value: viewModel.settings.language,
              onChanged: (newValue) => viewModel.setLanguage(newValue!),
              items:
                  ['中文', 'English'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
            ),
          ),
          // 模型选择
          ListTile(
            leading: const Icon(Icons.model_training),
            title: const Text('选择模型'),
            subtitle: viewModel.models.isEmpty ? const Text('加载失败或暂无可用模型', style: TextStyle(color: Colors.red)) : null,
            trailing:
                viewModel.models.isEmpty
                    ? IconButton(icon: const Icon(Icons.refresh), onPressed: () => viewModel.fetchModels())
                    : DropdownButton<String>(
                      value: viewModel.settings.selectedModel ?? viewModel.models.first.name,
                      onChanged: (newValue) => viewModel.setSelectedModel(newValue!),
                      items:
                          viewModel.models.map<DropdownMenuItem<String>>((model) {
                            return DropdownMenuItem<String>(
                              value: model.name,
                              child: Text(model.name),
                              // child: Text('${model.name} (${model.quantizationLevel}, ${model.size})'),
                            );
                          }).toList(),
                    ),
          ),
          // End List
        ],
      ),
    );
  }
}
