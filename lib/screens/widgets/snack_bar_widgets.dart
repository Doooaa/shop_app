import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
  required Color snackColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: snackColor,
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ),
  );
}
