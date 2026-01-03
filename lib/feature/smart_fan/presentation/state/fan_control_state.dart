class FanControlState {
  final bool power;
  final int speed;
  final bool sleep;
  final int timer;
  final bool light;
  final int brightness;
  final String lightMode;

  const FanControlState({
    this.power = false,
    this.speed = 3,
    this.sleep = false,
    this.timer = 0,
    this.light = false,
    this.brightness = 50,
    this.lightMode = 'daylight',
  });

  FanControlState copyWith({
    bool? power,
    int? speed,
    bool? sleep,
    int? timer,
    bool? light,
    int? brightness,
    String? lightMode,
  }) {
    return FanControlState(
      power: power ?? this.power,
      speed: speed ?? this.speed,
      sleep: sleep ?? this.sleep,
      timer: timer ?? this.timer,
      light: light ?? this.light,
      brightness: brightness ?? this.brightness,
      lightMode: lightMode ?? this.lightMode,
    );
  }
}
