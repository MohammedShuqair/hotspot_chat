import 'package:hotspot_chat/services/permisiion/app_permission.dart';
import 'package:hotspot_chat/utils/format_ip.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'network_information.dart';

class NetworkInformationImpl extends NetworkInformationService {
  NetworkInformationImpl(AppPermissionService appPermission)
      : super(appPermission: appPermission);

  @override
  Future<String?> getDeviceIP() async {
    if (await appPermission.requestLocationPermission()) {
      final ip = await NetworkInfo().getWifiIP();
      if (ip != null) {
        return IPFormatter.convertToWesternArabicNumerals(ip);
      }
    }
    return null;
  }
}
