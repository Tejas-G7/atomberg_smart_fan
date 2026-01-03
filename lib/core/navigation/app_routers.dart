import 'package:atomberg_smart_fan_controller/feature/smart_fan/presentation/ui/smart_fan_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/auth_creds/view/user_input_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.authCreds:
        return MaterialPageRoute(builder: (_) => const UserInputScreen());

      case AppRoutes.smartFanScreen:
        return MaterialPageRoute(builder: (_) => const SmartFanScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
