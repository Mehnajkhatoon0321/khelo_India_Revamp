import 'package:flutter/services.dart';

/// NSRS ID: exactly 10 digits (0-9) when only digits typed.
/// Email: full email chars when @ or letters typed.
class NsrsOrEmailInputFormatter extends TextInputFormatter {
  static const int _nsrsMaxLength = 10;
  static const int _emailMaxLength = 128;
  static final RegExp _digitOnly = RegExp(r'[0-9]');
  static final RegExp _emailChar = RegExp(r'[A-Za-z0-9._%+@-]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text;
    final bool hasAt = newText.contains('@');
    final bool hasLetter = newText.contains(RegExp(r'[A-Za-z]'));

    // Email mode: has @ or contains letters (typing email)
    final bool isEmailMode = hasAt || hasLetter;

    if (isEmailMode) {
      final StringBuffer buffer = StringBuffer();
      for (int i = 0;
          i < newText.length && buffer.length < _emailMaxLength;
          i++) {
        final String char = newText[i];
        if (_emailChar.hasMatch(char) || char == '@' || char == '.') {
          buffer.write(char);
        }
      }
      final String filtered = buffer.toString();
      return TextEditingValue(
        text: filtered,
        selection: TextSelection.collapsed(offset: filtered.length),
      );
    }

    // NSRS mode: digits only, max 10
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < newText.length && buffer.length < _nsrsMaxLength; i++) {
      final String char = newText[i];
      if (_digitOnly.hasMatch(char)) {
        buffer.write(char);
      }
    }
    final String filtered = buffer.toString();
    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}
