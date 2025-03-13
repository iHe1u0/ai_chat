import 'package:chat/views/chat/chat_screen.dart' show ChatScreen;
import 'package:chat/views/settings/settings_screen.dart' show SettingsScreen;
import 'package:go_router/go_router.dart' show GoRoute, GoRouter;

final GoRouter router = GoRouter(
  initialLocation: '/chat',
  routes: [
    // GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/chat', builder: (context, state) => ChatScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
  ],
);
