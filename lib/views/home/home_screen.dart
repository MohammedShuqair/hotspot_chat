import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/controllers/network_controller.dart';
import 'package:hotspot_chat/services/network/network_devices_service/network_devices_service.dart';
import 'package:hotspot_chat/services/network/network_devices_service/network_devices_service_ping.dart';
import 'package:hotspot_chat/services/network/network_information/network_information_impl.dart';
import 'package:hotspot_chat/services/permisiion/app_permission_impl.dart';
import 'package:hotspot_chat/views/scan/scan_screen.dart';
import 'package:hotspot_chat/views/shared/app_text_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void getNetworkDevices() {
    NetworkDevicesService networkDevicesService =
        NetworkDevicesServicePing(NetworkInformationImpl(AppPermissionImpl()));
    networkDevicesService.getNetworkDevices();
  }

  final TextEditingController _ipController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotspot Chat'),
      ),
      body: Consumer<NetworkController>(
        builder: (context, provider, child) {
          if (!provider.isInitialized()) {
            return Center(
                child: MaterialButton(
              onPressed: () {
                provider.init();
              },
              child: Text('Retry'),
            ));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextField(
                        controller: _ipController,
                        keyboardType: TextInputType.number,
                        hintText: "Destination IP Address",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!RegExp(
                                  r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")
                              .hasMatch(value)) {
                            return 'Please enter a valid IP Address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                provider.checkDestinationConnection(
                                    _ipController.text);
                              }
                            },
                            child: const Text('Check Connection'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                provider.syncChat(_ipController.text);
                              }
                            },
                            child: const Text('Sync Chat'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ScanScreen();
          }));
        },
        label: Text("Scan"),
        icon: Icon(Icons.wifi),
      ),
    );
  }
}
