import 'dart:io';

import 'package:hotspot_chat/models/device_response.dart';
import 'package:hotspot_chat/services/network/network_devices_service/network_devices_service.dart';
import 'package:hotspot_chat/utils/format_ip.dart';

class NetworkDevicesServicePing extends NetworkDevicesService {
  NetworkDevicesServicePing(super.networkInformation);

  @override
  Future<List<String>> getNetworkDevices() async {
    List<String> ips = [];
    String? ip = await networkInformation.getDeviceIP();
    if (ip != null) {
      ip = IPFormatter.convertToWesternArabicNumerals(ip);

      print("IP: $ip");

      final String subnet = ip.substring(0, ip.lastIndexOf('.'));
      for (var i = 1; i < 255; i++) {
        String targetIP = '$subnet.$i';
        print(targetIP);
        try {
          ProcessResult result =
              await Process.run('ping', ['-c', '1', targetIP]);
          ips.add(targetIP);

          if (result.exitCode == 0) {
            ips.add(targetIP);
          }
        } catch (e) {
          print("error: $e");
        }
      }
      print('Done');
    }
    return ips;
  }

  @override
  Stream<List<DeviceResponse>> getNetworkDevicesStream() async* {
    List<DeviceResponse> ips = [];
    String? ip = await networkInformation.getDeviceIP();

    if (ip != null) {
      ip = IPFormatter.convertToWesternArabicNumerals(ip);
      print("IP: $ip");

      final String subnet = ip.substring(0, ip.lastIndexOf('.'));

      for (var i = 1; i < 255; i++) {
        String targetIP = '$subnet.$i';
        print(targetIP);
        try {
          ProcessResult result =
              await Process.run('ping', ['-c', '1', targetIP]);

          if (result.exitCode == 0) {
            ips.add(DeviceResponse(scanPercent: i / 254, ip: targetIP));
            yield List<DeviceResponse>.from(ips);
          } else {
            if (ips.isNotEmpty) {
              ips.last.scanPercent = i / 255;
              yield List<DeviceResponse>.from(ips);
            }
          }
        } catch (e) {
          print("error: $e");
        }
      }
      print('Done');
    }
  }
}
