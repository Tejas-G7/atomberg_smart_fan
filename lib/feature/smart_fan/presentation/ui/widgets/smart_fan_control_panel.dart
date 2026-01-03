import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/smart_fan_bloc.dart';
import '../../bloc/smart_fan_event.dart';
import '../../bloc/smart_fan_state.dart';
import '../../state/fan_control_state.dart';

class SmartFanControlPanel extends StatelessWidget {
  final String deviceId;

  const SmartFanControlPanel({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartFanBloc, SmartFanState>(
      builder: (context, state) {
        if (state is! SmartFanLoadedState) {
          return const Center(child: CircularProgressIndicator());
        }

        final FanControlState control = state.controls[deviceId] ?? FanControlState();

        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.75,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (_, controller) {
              return ListView(
                controller: controller,
                padding: const EdgeInsets.all(16),
                children: [
                  _header(),
                  const SizedBox(height: 16),

                  _powerTile(context, deviceId, control),
                  const Divider(),

                  _speedControl(context, deviceId, control),
                  const Divider(),

                  _sleepMode(context, deviceId, control),
                  const Divider(),

                  _timerControl(context, deviceId, control),
                  const Divider(),

                  _lightControl(context, deviceId, control),
                  const Divider(),

                  _brightnessControl(context, deviceId, control),
                  const Divider(),

                  _colorControl(context, deviceId, control),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _powerTile(
    BuildContext context,
    String deviceId,
    FanControlState control,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.power_settings_new),
      title: const Text("Power"),
      value: control.power,
      onChanged: (val) {
        context.read<SmartFanBloc>().add(SetPower(deviceId, val));
      },
    );
  }

  Widget _speedControl(
    BuildContext context,
    String deviceId,
    FanControlState control,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Speed", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                context.read<SmartFanBloc>().add(ChangeSpeed(deviceId, -1));
              },
            ),
            Text("Speed: ${control.speed}"),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.read<SmartFanBloc>().add(ChangeSpeed(deviceId, 1));
              },
            ),
          ],
        ),
        Slider(
          min: 1,
          max: 6,
          divisions: 5,
          value: control.speed.toDouble(),
          onChanged: (val) {
            context.read<SmartFanBloc>().add(SetSpeed(deviceId, val.toInt()));
          },
        ),
      ],
    );
  }

  Widget _sleepMode(
    BuildContext context,
    String deviceId,
    FanControlState control,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.nightlight_round),
      title: const Text("Sleep Mode"),
      value: control.sleep,
      onChanged: (val) {
        context.read<SmartFanBloc>().add(SetSleepMode(deviceId, val));
      },
    );
  }

  Widget _timerControl(
    BuildContext context,
    String deviceId,
    FanControlState control,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Timer", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _timerButton(context, deviceId, "Off", 0, control.timer),
            _timerButton(context, deviceId, "1h", 1, control.timer),
            _timerButton(context, deviceId, "2h", 2, control.timer),
            _timerButton(context, deviceId, "3h", 3, control.timer),
            _timerButton(context, deviceId, "6h", 4, control.timer),
          ],
        ),
      ],
    );
  }

  Widget _timerButton(
    BuildContext context,
    String deviceId,
    String label,
    int value,
    int selectedValue,
  ) {
    final isSelected = value == selectedValue;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : null,
      ),
      onPressed: () {
        context.read<SmartFanBloc>().add(SetTimer(deviceId, value));
      },
      child: Text(label),
    );
  }

  Widget _lightControl(
    BuildContext context,
    String deviceId,
    FanControlState control,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.lightbulb),
      title: const Text("Light"),
      value: control.light,
      onChanged: (val) {
        context.read<SmartFanBloc>().add(SetLightPower(deviceId, val));
      },
    );
  }

  Widget _brightnessControl(
    BuildContext context,
    String deviceId,
    FanControlState control,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Brightness", style: TextStyle(fontSize: 16)),
        Slider(
          min: 10,
          max: 100,
          divisions: 9,
          value: control.brightness.toDouble(),
          onChanged: (val) {
            context.read<SmartFanBloc>().add(
              SetBrightness(deviceId, val.toInt()),
            );
          },
        ),
      ],
    );
  }

  Widget _colorControl(
    BuildContext context,
    String deviceId,
    FanControlState control,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _colorButton(context, deviceId, "Warm", Colors.orange, "warm", control),
        _colorButton(context, deviceId, "Cool", Colors.blue, "cool", control),
        _colorButton(
          context,
          deviceId,
          "Day",
          Colors.grey,
          "daylight",
          control,
        ),
      ],
    );
  }

  Widget _colorButton(
    BuildContext context,
    String deviceId,
    String label,
    Color color,
    String mode,
    FanControlState control,
  ) {
    final isSelected = control.lightMode == mode;

    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.circle, color: isSelected ? Colors.green : color),
          onPressed: () {
            context.read<SmartFanBloc>().add(SetLightColor(deviceId, mode));
          },
        ),
        Text(label),
      ],
    );
  }

  Widget _header() {
    return Center(
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
