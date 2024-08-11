import 'package:flutter/material.dart';
import 'package:hotspot_chat/views/shared/snak_bar.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> navigateTo(
    Widget widget,
  ) async {
    await navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) => widget));
  }

  static Future<void> navigateReplacementTo(
    Widget widget,
  ) async {
    await navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (_) => widget));
  }

  static Future<void> navigateAndRemoveUntilTo(
    Widget widget,
  ) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => widget,
          ),
          (route) => false);
    });
  }

  static void goBack() {
    return navigatorKey.currentState?.pop();
  }

  static void showSnackBar(String message) async {
    await navigatorKey.currentContext?.showSnackBar(message);
  }

  static Future<void> showDialog(Widget dialog) async {
    if (navigatorKey.currentContext != null) {
      await showAdaptiveDialog(
          context: navigatorKey.currentContext!,
          builder: (_) {
            return Material(child: dialog);
          });
    }
  }
}
