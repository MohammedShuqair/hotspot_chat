import 'package:flutter/material.dart';

extension SnakBar on BuildContext {
  Future<void> showSnackBar(String message) async {
    await ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
