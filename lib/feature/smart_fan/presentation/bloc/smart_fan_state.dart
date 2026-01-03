import 'package:atomberg_smart_fan_controller/feature/smart_fan/presentation/state/fan_control_state.dart';

import '../../domain/entities/devices.dart';

abstract class SmartFanState {}

class SmartFanLoadingState extends SmartFanState {}

class SmartFanErrorState extends SmartFanState {
  final String message;

  SmartFanErrorState(this.message);
}


class SmartFanLoadedState extends SmartFanState {
  final List<SmartDevice> devices;
  final Map<String, FanControlState> controls;

  SmartFanLoadedState({required this.devices, required this.controls});

  SmartFanLoadedState copyWith({
    List<SmartDevice>? devices,
    Map<String, FanControlState>? controls,
  }) {
    return SmartFanLoadedState(
      devices: devices ?? this.devices,
      controls: controls ?? this.controls,
    );
  }
}
