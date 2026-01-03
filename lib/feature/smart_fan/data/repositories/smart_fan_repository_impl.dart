import 'dart:convert';

import 'package:atomberg_smart_fan_controller/core/constants/auth_constant.dart';
import 'package:atomberg_smart_fan_controller/core/constants/response_status.dart';
import 'package:atomberg_smart_fan_controller/core/data/model/atomberg_error.dart';
import 'package:atomberg_smart_fan_controller/core/network/atomberg_client.dart';
import 'package:atomberg_smart_fan_controller/core/types/result.dart';
import 'package:atomberg_smart_fan_controller/feature/smart_fan/data/model/device_list.dart';
import 'package:atomberg_smart_fan_controller/feature/smart_fan/domain/entities/devices.dart';
import 'package:atomberg_smart_fan_controller/feature/smart_fan/domain/repositories/smart_fan_repository.dart';

class SmartFanRepositoryImpl implements SmartFanRepository {
  final AtombergClient client;

  SmartFanRepositoryImpl(this.client);

  @override
  Future<Result<Appliances, AtombergError>> getAllDevices() async {
    try {
      final response = await client.get(
        Uri.parse(AuthConstant.baseUrl + AuthConstant.listOfDevices),
      );
      if (response.statusCode == ResponseStatus.success.code) {
        final appliances = DeviceListDto.fromJson(
          jsonDecode(response.body),
        ).toDomain();
        return Result.success(appliances);
      } else {
        return Result.error(
          AtombergError(
            "Status Code: ${response.statusCode} | ${response.statusCode.statusCodeHint}",
          ),
        );
      }
    } catch (e) {
      return Result.error(AtombergError("Unexpected Error: $e"));
    }
  }

  @override
  Future<Result<String, AtombergError>> sendCommands(
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(AuthConstant.baseUrl + AuthConstant.sendCommand),
        body: jsonEncode(payload),
      );
      if (response.statusCode == ResponseStatus.success.code) {
        return Result.success("send Commands ${response.body}");
      } else {
        return Result.error(
          AtombergError(
            "Status Code: ${response.statusCode} | ${response.statusCode.statusCodeHint}",
          ),
        );
      }
    } catch (e) {
      return Result.error(AtombergError("Unexpected Error: $e"));
    }
  }
}
