import 'package:atomberg_smart_fan_controller/feature/smart_fan/presentation/state/fan_control_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/fan_command_builder.dart';
import '../../domain/entities/fan_command_payload.dart';
import '../../domain/repositories/smart_fan_repository.dart';
import 'smart_fan_event.dart';
import 'smart_fan_state.dart';

class SmartFanBloc extends Bloc<SmartFanEvent, SmartFanState> {
  final SmartFanRepository repository;

  SmartFanBloc(this.repository) : super(SmartFanLoadingState()) {
    on<LoadSmartFans>(_onLoadFans);

    on<SetPower>(_onCommand);
    on<SetSpeed>(_onCommand);
    on<ChangeSpeed>(_onCommand);
    on<SetSleepMode>(_onCommand);
    on<SetTimer>(_onCommand);
    on<SetLightPower>(_onCommand);
    on<SetBrightness>(_onCommand);
    on<ChangeBrightness>(_onCommand);
    on<SetLightColor>(_onCommand);
  }

  Future<void> _onLoadFans(
    LoadSmartFans event,
    Emitter<SmartFanState> emit,
  ) async {
    emit(SmartFanLoadingState());

    final response = await repository.getAllDevices();
    final devices = response.success?.listOfDevices ?? [];

    final controls = {
      for (final d in devices) d.deviceId!: const FanControlState(),
    };

    emit(SmartFanLoadedState(devices: devices, controls: controls));
  }

  Future<void> _onCommand(
    SmartFanEvent event,
    Emitter<SmartFanState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SmartFanLoadedState) return;

    final payload = _buildPayload(event);
    await repository.sendCommands(payload.toJson());

    final deviceId = payload.deviceId;
    final oldControl = currentState.controls[deviceId]!;

    final updatedControl = _applyEvent(oldControl, event);

    emit(
      currentState.copyWith(
        controls: {...currentState.controls, deviceId: updatedControl},
      ),
    );
  }

  FanControlState _applyEvent(FanControlState control, SmartFanEvent event) {
    if (event is SetPower) return control.copyWith(power: event.value);
    if (event is SetSpeed) return control.copyWith(speed: event.speed);
    if (event is ChangeSpeed) {
      return control.copyWith(speed: control.speed + event.delta);
    }
    if (event is SetSleepMode) return control.copyWith(sleep: event.enabled);
    if (event is SetTimer) return control.copyWith(timer: event.hours);
    if (event is SetLightPower) return control.copyWith(light: event.enabled);
    if (event is SetBrightness) {
      return control.copyWith(brightness: event.value);
    }
    if (event is ChangeBrightness) {
      return control.copyWith(brightness: control.brightness + event.delta);
    }
    if (event is SetLightColor) return control.copyWith(lightMode: event.mode);

    return control;
  }

  FanCommandPayload _buildPayload(SmartFanEvent event) {
    if (event is SetPower) {
      return FanCommandBuilder.power(event.deviceId, event.value);
    }
    if (event is SetSpeed) {
      return FanCommandBuilder.speed(event.deviceId, event.speed);
    }
    if (event is ChangeSpeed) {
      return FanCommandBuilder.speedDelta(event.deviceId, event.delta);
    }
    if (event is SetSleepMode) {
      return FanCommandBuilder.sleep(event.deviceId, event.enabled);
    }
    if (event is SetTimer) {
      return FanCommandBuilder.timer(event.deviceId, event.hours);
    }
    if (event is SetLightPower) {
      return FanCommandBuilder.light(event.deviceId, event.enabled);
    }
    if (event is SetBrightness) {
      return FanCommandBuilder.brightness(event.deviceId, event.value);
    }
    if (event is ChangeBrightness) {
      return FanCommandBuilder.brightnessDelta(event.deviceId, event.delta);
    }
    if (event is SetLightColor) {
      return FanCommandBuilder.lightMode(event.deviceId, event.mode);
    }

    throw Exception('Unsupported SmartFanEvent');
  }
}
