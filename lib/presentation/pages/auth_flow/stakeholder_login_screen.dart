import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gms_application/core/constants/common_input_decoration.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/widgets/flutter_animation.dart';
import 'package:gms_application/core/utils/nsrs_or_email_input_formatter.dart';
import 'package:gms_application/core/storage/shared_preference.dart';
import 'package:gms_application/core/utils/validator.dart';
import 'package:gms_application/presentation/pages/auth_flow/forgot_password_screen.dart';

class StakeholderLoginScreen extends StatefulWidget {
  const StakeholderLoginScreen({super.key});

  @override
  State<StakeholderLoginScreen> createState() => _StakeholderLoginScreenState();
}

class _StakeholderLoginScreenState extends State<StakeholderLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _hasTriedSubmit = false;

  static const double _formMaxWidth = 400;
  static const double _horizontalPadding = 24;
  static const double _verticalPadding = 24;
  static const double _logoSize = 56;
  static const double _buttonHeight = 56;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() {
    final rememberMe = Prefs.getRememberMe();
    if (rememberMe) {
      _usernameController.text = Prefs.getUserEmailLogin();
      _passwordController.text = Prefs.getUserPassword();
    }
    setState(() => _rememberMe = rememberMe);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveOrClearCredentials() async {
    if (_rememberMe) {
      await Prefs.setRememberMe(true);
      await Prefs.setUserEmailLogin(_usernameController.text.trim());
      await Prefs.setUserPassword(_passwordController.text);
    } else {
      await Prefs.setRememberMe(false);
      await Prefs.setUserEmailLogin('');
      await Prefs.setUserPassword('');
    }
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    setState(() => _hasTriedSubmit = true);
    if (!_formKey.currentState!.validate()) return;

    _saveOrClearCredentials();

    final String usernameOrEmail = _usernameController.text.trim();
    final String loginType =
        usernameOrEmail.contains('@') ? 'email' : 'nsrsId';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Validated for $loginType login.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Constants.loginBackgroundPath,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _horizontalPadding,
                        vertical: _verticalPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: _formMaxWidth,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildLogo(),
                                  const SizedBox(height: 32),
                                  _buildHeader(),
                                  const SizedBox(height: 36),
                                  _buildUsernameField(),
                                  const SizedBox(height: 20),
                                  _buildPasswordField(),
                                  const SizedBox(height: 20),
                                  _buildRememberAndForgot(),
                                  const SizedBox(height: 28),
                                  _buildSubmitButton(),
                                ],
                              ),
                            ),
                          ),
                          ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        Constants.loginLogoPath,
        width: _logoSize,
        height: _logoSize,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.whiteColors,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.sports,
            size: 36,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    ).animation.fadeScale(duration: 600.ms);
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          Constants.loginWelcomeTitle,
          textAlign: TextAlign.center,
          style: FTextStyle.loginTitleStyle,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            Constants.loginSubtitle,
            textAlign: TextAlign.center,
            style: FTextStyle.loginSubtitleStyle,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 150.ms, duration: 500.ms);
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: FTextStyle.loginInputStyle,
      inputFormatters: [
        NsrsOrEmailInputFormatter(),
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      validator: ValidatorUtils.nsrsOrEmailValidator,
      autovalidateMode: _hasTriedSubmit
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      decoration: CommonInputDecoration.loginEmailStyle(),
    )
        .animate()
        .fadeIn(delay: 250.ms, duration: 400.ms)
        .slideY(begin: 0.15, end: 0, curve: Curves.easeOut);
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      style: FTextStyle.loginInputStyle,
      onFieldSubmitted: (_) => _onSubmit(),
      validator: ValidatorUtils.passwordValidator,
      autovalidateMode: _hasTriedSubmit
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      decoration: CommonInputDecoration.loginPasswordStyle(
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.whiteColors,
            size: 22,
          ),
          onPressed: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 320.ms, duration: 400.ms)
        .slideY(begin: 0.15, end: 0, curve: Curves.easeOut);
  }

  Widget _buildRememberAndForgot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: _rememberMe,
              checkColor: AppColors.whiteColors,
              activeColor: AppColors.secondaryColor,
              side: BorderSide(
                color: AppColors.whiteColors.withOpacity(0.8),
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) {
                setState(() => _rememberMe = value ?? false);
              },
            ),
          ),
          const SizedBox(width: 10),
          Text(
            Constants.rememberMeTxt,
            style: FTextStyle.loginRememberMeStyle,
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ForgotPasswordScreen(),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              Constants.loginForgotPassword,
              style: FTextStyle.loginForgotPasswordStyle,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 400.ms, duration: 350.ms);
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: _buttonHeight,
      child: ElevatedButton(
        onPressed: _onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.whiteColors,
          foregroundColor: AppColors.textPrimary,
          side: BorderSide(
            color: AppColors.whiteColors.withOpacity(0.4),
            width: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          shadowColor: AppColors.black.withOpacity(0.2),
        ),
        child: Text(
          Constants.loginSubmit,
          style: FTextStyle.loginButtonStyle,
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 480.ms, duration: 400.ms)
        .slideY(begin: 0.12, end: 0, curve: Curves.easeOut);
  }
}
