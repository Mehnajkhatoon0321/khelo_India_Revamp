import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';

Future<bool> showCommonExitPopup({
  required BuildContext context,
  String title = 'Exit App?',
  String message = 'Are you sure do you want to exit?',
  String cancelText = 'Cancel',
  String confirmText = 'Okay',
}) async {
  final bool? shouldExit = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierColor: AppColors.black.withOpacity(0.5),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColors,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.16),
                blurRadius: 26,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.12),
                ),
                child: const Icon(
                  Icons.exit_to_app_rounded,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 14),
              TrText(
                title,
                style: FTextStyle.textSecBlackStylePrimary.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TrText(
                message,
                textAlign: TextAlign.center,
                style: FTextStyle.textSecBlackStylePrimary.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.primaryColor.withOpacity(0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: TrText(
                        cancelText,
                        style: FTextStyle.helloTxt.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: TrText(
                        confirmText,
                        style: FTextStyle.helloTxt.copyWith(
                          color: AppColors.whiteColors,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return shouldExit ?? false;
}
