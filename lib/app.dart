import 'package:chat/core/config/theme.dart' show AppTheme;
import 'package:chat/routes/app_routes.dart' show router;
import 'package:flutter/material.dart';
// import 'routes/app_routes.dart';
// import 'core/config/theme.dart';

class KApp extends StatelessWidget {
  const KApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chat App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
