import 'package:device_info_plus/device_info_plus.dart';

import 'device_identifier.dart';

class DeviceIdentifierServiceImpl implements DeviceIdentifierService {
  @override
  Future<String> getDeviceIdentifier() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    final AndroidDeviceInfo deviceIdentifier = await plugin.androidInfo;
    return deviceIdentifier.id;
  }
}
