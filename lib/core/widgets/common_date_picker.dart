import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/themes_colors.dart';

Future<DateTime?> showCommonDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  String? helpText,
}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    helpText: helpText,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.whiteColors,
                surface: AppColors.whiteColors,
                onSurface: AppColors.textPrimary,
              ),
        ),
        child: child!,
      );
    },
  );
}
