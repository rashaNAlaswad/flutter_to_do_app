import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import '../routes/extensions.dart';
import '../utils/app_strings.dart';
import '../utils/app_colors.dart';

String? validateString(String? value, String message) {
  if (value == null || value.isEmpty) {
    return message;
  }
  return null;
}

void showSnackBar(
    {required BuildContext context,
    required String message,
    required SnakeState state}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: getState(state),
        content: Text(message),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating),
  );
}

enum SnakeState { success, error }

Color getState(SnakeState state) {
  switch (state) {
    case SnakeState.error:
      return AppColors.red;
    case SnakeState.success:
      return AppColors.green;
  }
}

void openAppSettings() {
  AppSettings.openAppSettings();
}

void showPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(AppStrings.dialogTitle),
        content: const Text(
          AppStrings.dialogContent,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              AppStrings.cancel,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              openAppSettings();
            },
            child: const Text(AppStrings.openSettings),
          ),
        ],
      );
    },
  );
}
