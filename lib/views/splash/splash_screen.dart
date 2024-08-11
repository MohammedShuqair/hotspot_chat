import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/controllers/network_controller.dart';
import 'package:hotspot_chat/models/data_response.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Consumer<NetworkController>(
          builder: (context, provider, child) {
            if (provider.userIpAddress?.status == DataStatus.ERROR) {
              return IconButton(
                onPressed: () {
                  provider.init();
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              );
            }
            return SizedBox.square(
                dimension: 100.r, child: Image.asset('assets/icons/app.png'));
          },
        ),
      ),
    );
  }
}
