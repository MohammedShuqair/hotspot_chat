import 'package:hotspot_chat/services/permisiion/app_permission.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionImpl implements AppPermissionService {
  @override
  Future<bool> requestLocationPermission() async {
    /*if (!await isLocationPermissionGranted()) {
  return  await isLocationPermissionGranted();
    }
    return true;*/
    return isLocationPermissionGranted();
  }

  Future<bool> isLocationPermissionGranted() async =>
      await Permission.location.request().isGranted;
}
