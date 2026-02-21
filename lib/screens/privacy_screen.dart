import 'package:flutter/material.dart';
import '../core/constants.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: AppColors.cardBg,
        foregroundColor: AppColors.neonBlue,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text('🔒', style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 10),
                    ShaderMask(
                      shaderCallback: (r) =>
                          AppColors.neonGradient.createShader(r),
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Last updated: February 2026',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const _Section('1. Introduction',
                  'Welcome to Xray Fun Camera – Skeleton Prank Simulator ("App", "we", "us", or "our"). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application. This App is for entertainment purposes only and does not perform real X-ray scanning or medical imaging.\n\nPlease read this policy carefully. By using the App, you agree to the collection and use of information in accordance with this policy.'),

              const _Section('2. Information We Collect',
                  'We do not collect personally identifiable information (PII) directly. The following types of data may be processed:\n\n• Camera Data: Photos taken within the app are processed entirely on your device and are NEVER uploaded to any server. All photo processing is local only.\n\n• Advertising Data: We use Google AdMob to display advertisements. AdMob may collect your Advertising ID, device information, and usage data to serve relevant ads. See Google\'s Privacy Policy for details.\n\n• Usage Analytics: Basic anonymous usage analytics may be collected automatically (e.g., app opens, feature usage) for improving the app. No personal data is included.\n\n• Preferences: App settings (sound, theme, disclaimer acceptance) are stored locally on your device using SharedPreferences. This data never leaves your device.'),

              const _Section('3. Camera Permission',
                  'The App requires camera access ONLY to allow you to take photos to apply the fun skeleton filter effect. Camera permission is requested at runtime. Photos are:\n\n• Processed entirely on-device\n• Never uploaded to any server\n• Only saved to your gallery/storage when you explicitly tap "Save"\n• Never shared without your explicit action (tapping "Share")'),

              const _Section('4. Storage Permission',
                  'Storage permission (if requested) is used ONLY to save filtered photos to your device\'s gallery when you choose to save an image. No other files are read or written.'),

              const _Section('5. Third-Party Services — Google AdMob',
                  'This App uses Google AdMob for advertising. AdMob is operated by Google LLC. AdMob may collect and use the following data:\n\n• Advertising ID (GAID) for personalized ad targeting\n• IP address\n• Device type and OS version\n• App usage data\n\nYou can opt out of personalized ads through your device settings under Google → Ads → Opt out of Ads Personalization.\n\nGoogle\'s Privacy Policy: https://policies.google.com/privacy\nAdMob Policies: https://support.google.com/admob/answer/6128543'),

              const _Section('6. Data Security',
                  'We implement appropriate technical measures to protect your local data. Since we do not transmit your photos or personal data to any server, the primary data security responsibility lies with your device manufacturer and OS. We have no access to photos processed by this app.'),

              const _Section('7. Children\'s Privacy',
                  'This App is not intended for children under 13 years of age without parental supervision. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe your child has provided personal information, please contact us so we can take appropriate action.'),

              const _Section('8. Your Rights',
                  'Depending on your jurisdiction, you may have the following rights:\n\n• Right to access information about data we hold\n• Right to deletion of your data\n• Right to opt out of personalized advertising\n\nSince we do not collect personal data directly (only AdMob may), most requests should be directed to Google. For app-specific preferences stored locally on your device, you can clear them by uninstalling the app.'),

              const _Section('9. Changes to This Policy',
                  'We may update this Privacy Policy from time to time. We will notify you of significant changes by updating the "Last updated" date at the top. Continued use of the App after changes constitutes acceptance of the revised policy.'),

              const _Section('10. Contact Us',
                  'If you have any questions, concerns, or requests regarding this Privacy Policy, please contact us:\n\nEmail: ${AppStrings.contactEmail}\n\nWe will respond to privacy inquiries within 30 days.'),

              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  '⚠️ This app is for entertainment purposes only. It does not perform real X-ray scanning, medical imaging, bone detection, or any health-related functionality.',
                  style: TextStyle(
                    color: AppColors.danger,
                    fontSize: 12,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;
  const _Section(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.neonBlue,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 13, height: 1.7),
          ),
          const Divider(color: Color(0x2200D4FF), height: 28),
        ],
      ),
    );
  }
}
