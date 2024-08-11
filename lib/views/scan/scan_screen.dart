import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/controllers/network_controller.dart';
import 'package:hotspot_chat/controllers/network_devices_controller.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // late NetworkController networkController;

  @override
  void initState() {
    // networkController = Provider.of<NetworkController>(context, listen: false)
    //   ..getIAllDevicesOfNetworkStream(context);
    // super.initState();
  }

  @override
  void dispose() {
    // networkController.cancelIPsStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NetworkDevicesController>(
      create: (_) => NetworkDevicesController(
          context.read<NetworkController>().networkDevicesService, context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("IP Scan"),
        ),
        body: Consumer<NetworkDevicesController>(
          builder: (context, provider, child) {
            if (provider.isError()) {
              return Center(
                  child: MaterialButton(
                onPressed: () {
                  provider.getIAllDevicesOfNetworkStream(context);
                },
                child: Text('Retry'),
              ));
            } else {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30.h,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Consumer<NetworkDevicesController>(
                      builder: (context, provider, child) {
                        return LinearProgressIndicator(
                          value: provider.devicesLoadingProgress(),
                          color: Colors.black,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  Consumer<NetworkDevicesController>(
                    builder: (context, provider, child) {
                      var devices = provider.otherIpAddresses?.data;
                      return SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        sliver: SliverList.separated(
                          itemCount: devices?.length ?? 0,
                          itemBuilder: (_, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  context
                                      .read<NetworkController>()
                                      .checkDestinationConnection(
                                          devices![index].ip);
                                },
                                title: Text(devices?[index].ip ?? ""),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => SizedBox(
                            height: 10.h,
                          ),
                        ),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ChatScreen(
                  //                   ipAddress: _ipController.text,
                  //                   connectionService: connectionService!,
                  //                 )));
                  //   },
                  //   child: const Text('Go'),
                  // ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
