import 'package:atomberg_smart_fan_controller/feature/auth_creds/presentation/bloc/auth_creds_bloc.dart';
import 'package:atomberg_smart_fan_controller/feature/smart_fan/presentation/bloc/smart_fan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/app_module.dart';
import 'core/navigation/app_routers.dart';
import 'core/navigation/app_routes.dart';
import 'feature/smart_fan/presentation/bloc/smart_fan_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(AtombergApp());
}

class AtombergApp extends StatelessWidget {
  const AtombergApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCredsBloc>()),
        BlocProvider(create: (_) => sl<SmartFanBloc>()..add(LoadSmartFans())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.authCreds,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
