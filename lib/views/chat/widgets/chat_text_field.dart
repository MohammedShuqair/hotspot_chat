import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/utils/colors.dart';
import 'package:hotspot_chat/views/shared/app_text_field.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.messageController,
    required this.sendMessage,
  });

  final TextEditingController messageController;
  final VoidCallback sendMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + (20.h)),
      child: Row(
        children: [
          Expanded(
              child: AppTextField(
            controller: messageController,
            hintText: "Enter your message",
          )),
          IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.send,
                color: AppColors.highlightColor,
              ))
        ],
      ),
    );
  }
}
