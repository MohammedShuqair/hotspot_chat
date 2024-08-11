import 'package:hotspot_chat/models/device_response.dart';
import 'package:hotspot_chat/services/network/network_information/network_information.dart';

abstract class NetworkDevicesService {
  final NetworkInformationService networkInformation;

  NetworkDevicesService(this.networkInformation);

  Future<List<String>> getNetworkDevices();

  Stream<List<DeviceResponse>> getNetworkDevicesStream();
}
