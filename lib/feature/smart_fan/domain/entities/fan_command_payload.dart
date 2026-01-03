class FanCommandPayload {
  final String deviceId;
  final Map<String, dynamic> command;

  FanCommandPayload({
    required this.deviceId,
    required this.command,
  });

  Map<String, dynamic> toJson() {
    return {
      "device_id": deviceId,
      "command": command,
    };
  }
}
