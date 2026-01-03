import 'package:atomberg_smart_fan_controller/feature/smart_fan/presentation/ui/widgets/smart_fan_control_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/devices.dart';
import '../../bloc/smart_fan_bloc.dart';

class FanCard extends StatelessWidget {
  final SmartDevice device;

  const FanCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openControlPanel(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(device.room, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.power_settings_new),
                  Icon(Icons.speed),
                  Icon(Icons.lightbulb),
                  Icon(Icons.bedtime),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openControlPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SmartFanBloc>(),
          child: SmartFanControlPanel(deviceId: device.deviceId),
        );
      },
    );
  }
}
