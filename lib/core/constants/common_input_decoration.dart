import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';

class CommonInputDecoration {
  CommonInputDecoration._();

  static const double _borderRadius = 16;

  static InputDecoration _baseDecoration({
    required String hintText,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    const OutlineInputBorder baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      borderSide: BorderSide(color: AppColors.loginInputBorder, width: 0.5),
    );
    const OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      borderSide: BorderSide(
        color: AppColors.loginInputBorderFocused,
        width: 1.2,
      ),
    );
    const OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      borderSide: BorderSide(color: AppColors.loginInputError, width: 0.8),
    );
    const OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      borderSide: BorderSide(color: AppColors.loginInputError, width: 1.2),
    );

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      hintText: hintText,
      hintStyle: FTextStyle.loginHintStyle,
      filled: true,
      fillColor: AppColors.loginInputFill,
      errorStyle: FTextStyle.formErrorTxtStyle.copyWith(
        color: AppColors.loginInputError,
      ),
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(minWidth: 50, minHeight: 24),
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIcon != null
          ? const BoxConstraints(minWidth: 48, minHeight: 48)
          : null,
      border: baseBorder,
      enabledBorder: baseBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: focusedErrorBorder,
    );
  }

  static InputDecoration loginEmailStyle() {
    return _baseDecoration(
      hintText: Constants.loginNsrsEmailHint,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 16, right: 12),
        child: Icon(
          Icons.person_outline,
          color: AppColors.whiteColors,
          size: 22,
        ),
      ),
    );
  }



  static InputDecoration loginPasswordStyle({required Widget suffixIcon}) {
    return _baseDecoration(
      hintText: Constants.loginPasswordHint,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 16, right: 12),
        child: Icon(
          Icons.lock_outline,
          color: AppColors.whiteColors,
          size: 22,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
