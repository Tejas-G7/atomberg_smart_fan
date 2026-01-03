import 'package:atomberg_smart_fan_controller/core/navigation/app_routes.dart';
import 'package:atomberg_smart_fan_controller/feature/smart_fan/presentation/ui/widgets/fan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/smart_fan_bloc.dart';
import '../bloc/smart_fan_state.dart';

class SmartFanScreen extends StatefulWidget {
  const SmartFanScreen({super.key});

  @override
  State<SmartFanScreen> createState() => _SmartFanScreenState();
}

class _SmartFanScreenState extends State<SmartFanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Fans'),
        leading: Icon(Icons.mode_fan_off_outlined),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.authCreds);
            },
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        child: BlocListener<SmartFanBloc, SmartFanState>(
          listener: (context, state) {
            if (state is SmartFanErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<SmartFanBloc, SmartFanState>(
            builder: (context, state) {
              if (state is SmartFanLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SmartFanLoadedState) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.devices.length,
                  itemBuilder: (context, index) {
                    return FanCard(
                      key: ValueKey(state.devices[index].deviceId),
                      device: state.devices[index],
                    );
                  },
                );
              }

              if (state is SmartFanErrorState) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
