import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class MessagesApp {
  static showCustom(
    BuildContext context,
    String message, {
    Color color = Colors.red,
    IconData icon = Icons.error,
  }) {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
  }
}
