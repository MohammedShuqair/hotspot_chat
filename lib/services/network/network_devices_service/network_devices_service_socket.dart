import 'dart:io';

import 'package:hotspot_chat/models/device_response.dart';
import 'package:hotspot_chat/utils/format_ip.dart';

import 'network_devices_service.dart';

class NetworkDevicesServiceSocket extends NetworkDevicesService {
  NetworkDevicesServiceSocket(super.networkInformation);

  int port = 44444;

  void setPort(int port) {
    this.port = port;
  }

  @override
  Future<List<String>> getNetworkDevices() async {
    String? ip = await networkInformation.getDeviceIP();
    List<String> devicesIp = [];
    if (ip != null) {
      final westernArabicIP = IPFormatter.convertToWesternArabicNumerals(ip);

      print("IP: $westernArabicIP");

      final String subnet =
          westernArabicIP.substring(0, westernArabicIP.lastIndexOf('.'));
      for (var i = 0; i < 256; i++) {
        String targetIP = '$subnet.$i';
        await Socket.connect(targetIP, port,
                timeout: Duration(milliseconds: 50))
            .then((socket) async {
          await InternetAddress(socket.address.address).reverse().then((value) {
            print("found device at $targetIP");
            print(value.host);
            print(socket.address.address);
            devicesIp.add(socket.address.address);
          }).catchError((error) {
            print(socket.address.address);
            print('Error: $error');
          });
          socket.destroy();
        }).catchError((error, stackTrace) {});
      }
    }
    return devicesIp;
  }

  @override
  Stream<List<DeviceResponse>> getNetworkDevicesStream() {
    // TODO: implement getNetworkDevicesStream
    throw UnimplementedError();
  }
}
