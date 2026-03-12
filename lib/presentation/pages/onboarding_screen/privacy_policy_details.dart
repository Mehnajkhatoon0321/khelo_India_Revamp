import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/widgets/responsive_layout.dart';

const String _privacyPolicyJson = r'''
{
  "sections": [
    {
      "title": "Introduction",
      "text": "This privacy policy governs your use of the Khelo India Games Mobile Application for mobile devices, which is hosted on the Google Play Store. The application is provided by the Sports Authority of India and is designed to offer pertinent information about Khelo India Games which of National Importance . Its primary aim is to disseminate pertinent information to stakeholders and provide enhanced services to citizens.\n\nThe content published on the Khelo India Games Mobile Application is sourced from the Games Technical Conduct Committee of the Khelo India Scheme implemented by Sports Authority of India The information provided is intended for general reference and may not have any legal sanctity unless specified otherwise. Although every effort is made to ensure the accuracy and reliability of the information through this application, users are advised to verify the correctness of the facts with the concerned authorities.\n\nThe Government of India and its allied establishments will not be responsible for the accuracy and correctness of the contents available in the Khelo India Games Mobile Application. This application aims to provide updated information on various sports events, training programs, and other activities related to the Khelo India initiative."
    },
    {
      "title": "User Provided Information:",
      "text": "As a general rule, this mobile application does not collect Personal Information about you when you visit the mobile application. You can use the mobile application without revealing Personal Information."
    },
    {
      "title": "Automatically Collected Information",
      "text": "The Khelo India Games Mobile Application, provided by the Sports Authority of India, does not automatically capture any specific personal information from you, such as current location/geo-coordinates, that allows us to identify you individually.\n\nIf the Khelo India Games Mobile Application requests you to provide current location/geo-coordinates, you will be informed of the specific purposes for which the information is gathered. Adequate security measures will be taken to protect your personal information.\n\nWe do not sell or share any personally identifiable information volunteered on the Khelo India Games Mobile Application to any third party (public/private). Any information provided to this application will be protected from loss, misuse, unauthorized access or disclosure, alteration, or destruction."
    },
    {
      "title": "User provided and Automatically collected Information Disclosure",
      "text": "We never disclose user provided personal information and automatically collected information with outside entities. You can stop all collection of information by the Application easily by uninstalling the Application. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network."
    },
    {
      "title": "Permission Required During installation by Khelo India Games Application",
      "text": "No permission are required during the installation of the Khelo India Games application."
    },
    {
      "title": "Permissions Required for Accessing the Self-Verification Feature of the Khelo India Games Application",
      "text": "In order to enhance the functionality and user experience of the Khelo India Games Application, specific permissions are requested from the user. These permissions are essential for the effective operation of certain features within the application, particularly the Self-Verification Feature. Below is a detailed explanation of the permissions required and their respective usage:"
    },
    {
      "title": "Location Access (Precise and Approximate Location):",
      "text": "The Khelo India Games Application requires access to your device's location services to determine your precise and approximate location. This information is critical for the Self-Verification Feature of the application. By accessing your location, the app can temporarily utilize this data to facilitate the process of marking attendance for stakeholders in the Khelo India Games Management System. This feature is designed to provide a seamless and efficient experience by eliminating the need for stakeholders to manually reach out to administrators for attendance verification.\n\nThe use of location data is strictly limited to the purposes mentioned and is handled with the utmost care for privacy and security. The location data is used ephemerally and is not stored permanently on our servers. We are committed to ensuring that your privacy is respected and that all data collected is used in accordance with our privacy policy and applicable laws.\n\nBy granting these permissions, you enable the Khelo India Games Application to operate effectively and provide a user-friendly experience."
    },
    {
      "title": "Camera Access",
      "text": "The application requires access to the camera of your mobile device. This permission is crucial for enabling the Self-Verification feature of the application. By accessing the camera, the application allows individuals to capture a selfie for the purpose of self-verification. This functionality empowers stakeholders to mark their attendance independently, without the need for any administrator intervention. The use of the camera is strictly limited to this purpose and is designed with user privacy and security in mind."
    },
    {
      "title": "Storage Access",
      "text": "The application requires permission to perform read and write operations on the external storage of your device. We ensure that this access is used solely for the intended purposes and that the data stored or retrieved is handled securely and responsibly, in compliance with our privacy policy and relevant current laws."
    },
    {
      "title": "Data Retention Policy, Managing Your Information",
      "text": "- User-Provided Data: We will retain data provided by users for the duration of their use of the application and for a reasonable period thereafter. This retention is essential to ensure the smooth functioning of the application and to provide a seamless user experience.\n- Automatically Collected Information: We would like to clarify that the Khelo India Games Application does not automatically collect any personal information from its users. Our policy is to respect the privacy and autonomy of our users, ensuring that no data is collected without explicit consent.\n- Storage and Protection of Data: Any data retained, will be stored securely and protected against unauthorized access, use, alteration, or destruction. After the end of the retention period, we may store data in an aggregated form, stripped of any personally identifiable information, primarily for analytical purposes to improve our application."
    },
    {
      "title": "Misuse by Non Targeted Users",
      "text": "Our mobile app is meant for use by the targeted audience only. Misuse by non-targeted users should be prevented by owner of the mobile."
    },
    {
      "title": "Security Measures for the Khelo India Games Application",
      "text": "At the Khelo India Games Application, provided by the Sports Authority of India, the security and confidentiality of your personal information are of utmost importance. We have implemented a comprehensive set of measures to safeguard the information you entrust to us. These measures are designed to protect your information from unauthorized access, disclosure, alteration, and destruction. Here is an overview of our security practices:\n- Physical Security Measures: We employ robust physical security controls to protect the infrastructure and environments where your information is stored. This includes secured facilities, controlled access, and surveillance systems.\n- Electronic Security Measures: To safeguard electronic data, we use advanced encryption, firewalls, intrusion detection systems, and secure software development practices. These technologies are regularly updated to address new security threats.\n- Ongoing Security Evaluation: We continuously assess and update our security practices to adapt to new challenges and ensure the protection of user information."
    },
    {
      "title": "Changes",
      "text": "This Privacy Policy may be updated from time to time for any reason. We will notify you of any changes to our Privacy Policy by posting the new Privacy Policy here. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes."
    },
    {
      "title": "Your Consent",
      "text": "By using the Khelo India Games Application, you acknowledge the measures we take to protect your information and our commitment to maintaining its security. We are dedicated to continuously enhancing our security measures to provide a safe and secure environment for our users."
    },
    {
      "title": "Contact Us",
      "text": "📧 Email: kheloindia[at][gov][dot]in"
    }
  ]
}
''';

class PrivacyPolicyDetails extends StatelessWidget {
  const PrivacyPolicyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_PrivacyPolicyContent>(
      future: _PrivacyPolicyContent.loadFromAsset(),
      builder: (context, snapshot) {
        final _PrivacyPolicyContent content =
            snapshot.data ?? _PrivacyPolicyContent.fallback();

        return Scaffold(
          backgroundColor: AppColors.whiteColors,
          appBar: const CommonAppBar(
            title: Constants.privacyPolicyTxt,
            showBack: true,
            showNotification: false,
            backgroundColor: AppColors.whiteColors,
            showBottomDivider: true,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: ResponsiveLayout.adaptiveHorizontalPadding(context),
                    right: ResponsiveLayout.adaptiveHorizontalPadding(context),
                    top: 16,
                    bottom: MediaQuery.of(context).padding.bottom + 28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _PrivacyHeaderCard(
                        title: 'We respect your privacy',
                        subtitle:
                            'Please read the policy below to understand how this app handles information and permissions.',
                      ),
                      SizedBox(height: 14.h),
                      for (final _PrivacySection section in content.sections)
                        _PrivacySectionCard(
                          title: section.title,
                          text: section.text,
                        ),
                      SizedBox(height: 18.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.lightPrimary,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppColors.scheduleCardBorder),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              size: 18.r,
                              color: AppColors.primaryColor.withOpacity(.80),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TrText(
                                'Last updated: Mar 2026',
                                style: FTextStyle.privacyDetailsMeta,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PrivacyHeaderCard extends StatelessWidget {
  const _PrivacyHeaderCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0, 4.h, 0, 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.scheduleCardBorder),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 44.r,
            width: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(.08),
              border: Border.all(color: AppColors.primaryColor.withOpacity(.12)),
            ),
            child: Icon(
              Icons.privacy_tip_outlined,
              size: 22.r,
              color: AppColors.primaryColor.withOpacity(.85),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TrText(
                  title,
                  style: FTextStyle.privacyDetailsHeaderTitle,
                ),
                SizedBox(height: 6.h),
                TrText(
                  subtitle,
                  style: FTextStyle.privacyDetailsHeaderSubtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacySectionCard extends StatelessWidget {
  const _PrivacySectionCard({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.scheduleCardBorder),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TrText(
            title,
            style: FTextStyle.privacyDetailsSectionTitle,
          ),
          SizedBox(height: 8.h),
          TrText(
            text,
            style: FTextStyle.privacyDetailsBody,
          ),
        ],
      ),
    );
  }
}

class _PrivacyPolicyContent {
  const _PrivacyPolicyContent({
    required this.sections,
  });

  final List<_PrivacySection> sections;

  static _PrivacyPolicyContent fallback() {
    return const _PrivacyPolicyContent(
      sections: <_PrivacySection>[
        _PrivacySection(
          title: 'Introduction',
          text:
              'This privacy policy governs your use of the Khelo India Games Mobile Application for mobile devices.',
        ),
      ],
    );
  }

  static Future<_PrivacyPolicyContent> loadFromAsset() async {
    try {
      final Map<String, dynamic> map =
          jsonDecode(_privacyPolicyJson) as Map<String, dynamic>;

      final List<dynamic> sectionsRaw =
          (map['sections'] as List<dynamic>? ?? <dynamic>[]);
      final List<_PrivacySection> sections = sectionsRaw
          .whereType<Map<String, dynamic>>()
          .map(_PrivacySection.fromMap)
          .toList();

      return _PrivacyPolicyContent(
        sections: sections.isEmpty ? fallback().sections : sections,
      );
    } catch (_) {
      return fallback();
    }
  }
}

class _PrivacySection {
  const _PrivacySection({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  static _PrivacySection fromMap(Map<String, dynamic> map) {
    return _PrivacySection(
      title: (map['title'] as String?)?.trim().isNotEmpty == true
          ? (map['title'] as String).trim()
          : 'Privacy section',
      text: (map['text'] as String?)?.trim().isNotEmpty == true
          ? (map['text'] as String).trim()
          : '',
    );
  }
}

// (Legacy) kept intentionally empty to avoid breaking any imports.
