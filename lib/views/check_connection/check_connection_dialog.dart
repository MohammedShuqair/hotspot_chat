import 'package:flutter/material.dart';
import 'package:hotspot_chat/models/user.dart';
import 'package:hotspot_chat/views/shared/dialog_skeleton.dart';

class CheckConnectionDialog extends StatelessWidget {
  const CheckConnectionDialog(
      {super.key, required this.user, required this.onAccept});

  final User user;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return DialogSkeleton(
        title: "Connection Request",
        body: 'User ${user.name} wants to connect with you',
        onAccept: onAccept);
  }
}
