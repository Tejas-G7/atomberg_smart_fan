import 'package:atomberg_smart_fan_controller/feature/smart_fan/domain/entities/devices.dart';

class DeviceListDto {
  final String status;
  final Message message;

  DeviceListDto({required this.status, required this.message});

  factory DeviceListDto.fromJson(Map<String, dynamic> json) {
    return DeviceListDto(
      status: json['status'],
      message: Message.fromJson(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message.toJson()};
  }

  Appliances toDomain() => Appliances(
    message.devicesList
        .map(
          (e) => SmartDevice(
            deviceId: e.deviceId,
            color: e.color,
            series: e.series,
            model: e.model,
            room: e.room,
            name: e.name,
          ),
        )
        .toList(),
  );
}

class Message {
  final List<Device> devicesList;

  Message({required this.devicesList});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      devicesList: (json['devices_list'] as List)
          .map((e) => Device.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'devices_list': devicesList.map((e) => e.toJson()).toList()};
  }
}

class Device {
  final Metadata metadata;
  final String deviceId;
  final String color;
  final String series;
  final String model;
  final String room;
  final String name;

  Device({
    required this.metadata,
    required this.deviceId,
    required this.color,
    required this.series,
    required this.model,
    required this.room,
    required this.name,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      metadata: Metadata.fromJson(json['metadata']),
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
      'metadata': metadata.toJson(),
      'device_id': deviceId,
      'color': color,
      'series': series,
      'model': model,
      'room': room,
      'name': name,
    };
  }
}

class Metadata {
  final String ssid;

  Metadata({required this.ssid});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(ssid: json['ssid']);
  }

  Map<String, dynamic> toJson() {
    return {'ssid': ssid};
  }
}
