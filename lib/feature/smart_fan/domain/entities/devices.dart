class Appliances {
  final List<SmartDevice> listOfDevices;

  Appliances(this.listOfDevices);

}
class SmartDevice {
  final String deviceId;
  final String color;
  final String series;
  final String model;
  final String room;
  final String name;

  SmartDevice({
    required this.deviceId,
    required this.color,
    required this.series,
    required this.model,
    required this.room,
    required this.name,
  });

  factory SmartDevice.fromJson(Map<String, dynamic> json) {
    return SmartDevice(
      deviceId: json['device_id'],
      color: json['color'],
      series: json['series'],
      model: json['model'],
      room: json['room'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'color': color,
      'series': series,
      'model': model,
      'room': room,
      'name': name,
    };
  }
}


