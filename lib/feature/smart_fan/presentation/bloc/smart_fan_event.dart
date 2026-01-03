abstract class SmartFanEvent {}

class LoadSmartFans extends SmartFanEvent {}

class SetPower extends SmartFanEvent {
  final String deviceId;
  final bool value;

  SetPower(this.deviceId, this.value);
}

class SetSpeed extends SmartFanEvent {
  final String deviceId;
  final int speed;

  SetSpeed(this.deviceId, this.speed);
}

class ChangeSpeed extends SmartFanEvent {
  final String deviceId;
  final int delta;

  ChangeSpeed(this.deviceId, this.delta);
}

class SetSleepMode extends SmartFanEvent {
  final String deviceId;
  final bool enabled;

  SetSleepMode(this.deviceId, this.enabled);
}

class SetTimer extends SmartFanEvent {
  final String deviceId;
  final int hours;

  SetTimer(this.deviceId, this.hours);
}

class SetLightPower extends SmartFanEvent {
  final String deviceId;
  final bool enabled;

  SetLightPower(this.deviceId, this.enabled);
}

class SetBrightness extends SmartFanEvent {
  final String deviceId;
  final int value;

  SetBrightness(this.deviceId, this.value);
}

class ChangeBrightness extends SmartFanEvent {
  final String deviceId;
  final int delta;

  ChangeBrightness(this.deviceId, this.delta);
}

class SetLightColor extends SmartFanEvent {
  final String deviceId;
  final String mode;

  SetLightColor(this.deviceId, this.mode);
}
