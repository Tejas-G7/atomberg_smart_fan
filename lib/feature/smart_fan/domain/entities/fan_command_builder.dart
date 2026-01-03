import 'fan_command_payload.dart';

class FanCommandBuilder {
  static FanCommandPayload power(String deviceId, bool value) {
    return FanCommandPayload(deviceId: deviceId, command: {"power": value});
  }

  static FanCommandPayload speed(String deviceId, int value) {
    return FanCommandPayload(deviceId: deviceId, command: {"speed": value});
  }

  static FanCommandPayload speedDelta(String deviceId, int delta) {
    return FanCommandPayload(
      deviceId: deviceId,
      command: {"speedDelta": delta},
    );
  }

  static FanCommandPayload sleep(String deviceId, bool value) {
    return FanCommandPayload(deviceId: deviceId, command: {"sleep": value});
  }

  static FanCommandPayload timer(String deviceId, int value) {
    return FanCommandPayload(deviceId: deviceId, command: {"timer": value});
  }

  static FanCommandPayload light(String deviceId, bool value) {
    return FanCommandPayload(deviceId: deviceId, command: {"led": value});
  }

  static FanCommandPayload brightness(String deviceId, int value) {
    return FanCommandPayload(
      deviceId: deviceId,
      command: {"brightness": value},
    );
  }

  static FanCommandPayload brightnessDelta(String deviceId, int delta) {
    return FanCommandPayload(
      deviceId: deviceId,
      command: {"brightnessDelta": delta},
    );
  }

  static FanCommandPayload lightMode(String deviceId, String mode) {
    return FanCommandPayload(deviceId: deviceId, command: {"light_mode": mode});
  }
}
