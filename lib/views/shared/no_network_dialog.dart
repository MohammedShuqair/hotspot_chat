import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/services/navigation_service/navigation_service.dart';

class NoNetworkDialog extends StatelessWidget {
  const NoNetworkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Network'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No network available\nPlease connect to a network',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextButton(
                onPressed: () {
                  NavigationService.goBack();
                },
                child: Text('Go Back')),
          ],
        ),
      ),
    );
  }
}
