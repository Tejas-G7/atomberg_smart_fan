import 'package:atomberg_smart_fan_controller/feature/smart_fan/domain/entities/devices.dart';

import '../../../../core/data/model/atomberg_error.dart';
import '../../../../core/types/result.dart';

abstract class SmartFanRepository {
  Future<Result<Appliances, AtombergError>> getAllDevices();

  Future<Result<String, AtombergError>> sendCommands(Map<String,dynamic> payload);
}
