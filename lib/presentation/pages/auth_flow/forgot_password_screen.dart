import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isLoading = true;
  WebViewController? _webViewController;
  String? _forgotPasswordUrl;

  @override
  void initState() {
    super.initState();
    final url = Constants.forgotPasswordUrl;
    setState(() => _forgotPasswordUrl = url);
    if (url != null && url.isNotEmpty) {
      _initWebView(url);
    } else {
      setState(() => _isLoading = false);
    }
  }

  void _initWebView(String url) {
    late final PlatformWebViewControllerCreationParams params;

    if (Platform.isAndroid) {
      params = AndroidWebViewControllerCreationParams();
    } else if (Platform.isIOS || Platform.isMacOS) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (_) => setState(() => _isLoading = false),
        ),
      );

    if (Platform.isAndroid) {
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    controller.loadRequest(Uri.parse(url));

    setState(() => _webViewController = controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColors),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          Constants.loginForgotPassword.replaceAll('?', ''),
          style: FTextStyle.headingTxtPrimary.copyWith(fontSize: 18),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _webViewController == null && _forgotPasswordUrl != null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.whiteColors),
      );
    }

    if (_forgotPasswordUrl == null || _forgotPasswordUrl!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Forgot password URL not configured.\nContact support.',
            textAlign: TextAlign.center,
            style: FTextStyle.formErrorTxtStyle.copyWith(
              color: AppColors.whiteColors,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    if (_webViewController == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.whiteColors),
      );
    }

    return Stack(
      children: [
        WebViewWidget(controller: _webViewController!),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(color: AppColors.whiteColors),
          ),
      ],
    );
  }
}
