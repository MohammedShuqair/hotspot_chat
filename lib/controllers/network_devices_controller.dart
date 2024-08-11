import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hotspot_chat/models/data_response.dart';
import 'package:hotspot_chat/models/device_response.dart';
import 'package:hotspot_chat/services/network/network_devices_service/network_devices_service.dart';
import 'package:hotspot_chat/views/shared/snak_bar.dart';

class NetworkDevicesController extends ChangeNotifier {
  StreamSubscription<List<DeviceResponse>>? ipsStreamSubscription;
  final NetworkDevicesService networkDevicesService;
  DataResponse<List<DeviceResponse>>? otherIpAddresses;

  NetworkDevicesController(this.networkDevicesService, BuildContext context) {
    getIAllDevicesOfNetworkStream(context);
  }

  bool isError() => otherIpAddresses?.status == DataStatus.ERROR;

  double devicesLoadingProgress() {
    if (otherIpAddresses?.data?.isNotEmpty ?? false) {
      return otherIpAddresses?.data?.last.scanPercent ?? 0;
    }
    return 0;
  }

  void getIAllDevicesOfNetworkStream(BuildContext context) async {
    try {
      otherIpAddresses = DataResponse.loading();
      notifyListeners();
      ipsStreamSubscription =
          networkDevicesService.getNetworkDevicesStream().listen((devicesIp) {
        otherIpAddresses = DataResponse.completed(devicesIp);
        notifyListeners();
      });
      ipsStreamSubscription?.onDone(() {
        context.showSnackBar("Scan completed");
      });
      ipsStreamSubscription?.onError((e) {
        context.showSnackBar("Please connect to a network");
        otherIpAddresses =
            DataResponse.error(message: "Please connect to a network");
        notifyListeners();
      });
    } catch (e) {
      context.showSnackBar("Error in getting devices");
      otherIpAddresses =
          DataResponse.error(message: "Please connect to a network");
      notifyListeners();
    }
  }

  @override
  void dispose() {
    ipsStreamSubscription?.cancel();
    super.dispose();
  }
}
