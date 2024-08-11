import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/utils/colors.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    super.key,
    required this.time,
    required this.message,
    required this.name,
    required this.isSender,
  });

  final String time;
  final String message;
  final String name;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.0.h),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
                Text(message)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
