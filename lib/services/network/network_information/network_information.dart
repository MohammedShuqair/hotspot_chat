import 'package:hotspot_chat/services/permisiion/app_permission.dart';

abstract class NetworkInformationService {
  final AppPermissionService appPermission;

  NetworkInformationService({required this.appPermission});

  Future<String?> getDeviceIP();
}
