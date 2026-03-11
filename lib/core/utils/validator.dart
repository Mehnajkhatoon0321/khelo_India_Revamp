class ValidatorUtils {
  ValidatorUtils._();

  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  static final RegExp _nsrsRegex = RegExp(r'^[0-9]{10}$');

  static String? emailValidator(String? value) {
    final String input = value?.trim() ?? '';
    if (input.isEmpty) return 'Please enter email';
    if (!_emailRegex.hasMatch(input)) return 'Please enter a valid email';
    return null;
  }

  static String? nsrsOrEmailValidator(String? value) {
    final String input = value?.trim() ?? '';

    if (input.isEmpty) {
      return 'Please enter NSRS ID or Email';
    }

    if (_emailRegex.hasMatch(input)) {
      return null;
    }

    if (_nsrsRegex.hasMatch(input)) {
      return null;
    }

    return 'Enter a valid NSRS ID (10 digits) or Email';
  }

  static String? passwordValidator(String? value) {
    final String password = value?.trim() ?? '';
    if (password.isEmpty) return 'Please enter password';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}

