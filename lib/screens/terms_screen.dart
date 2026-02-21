import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Terms of Use'),
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
                    Text('📄', style: TextStyle(fontSize: 40.sp)),
                    SizedBox(height: 10.h),
                    ShaderMask(
                      shaderCallback: (r) =>
                          AppColors.neonGradient.createShader(r),
                      child: Text(
                        'Terms of Use',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Effective Date: February 2026',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const _Section('1. Acceptance of Terms',
                  'By downloading, installing, or using Xray Fun Camera – Skeleton Prank Simulator ("the App"), you agree to be bound by these Terms of Use. If you do not agree to these terms, please do not use the App.'),

              const _Section('2. Entertainment Purpose Only',
                  'THE APP IS STRICTLY FOR ENTERTAINMENT, FUN, AND AMUSEMENT PURPOSES ONLY.\n\nThe App applies a fun, decorative skeleton graphic overlay to photos. It does NOT:\n• Perform real X-ray scanning of any kind\n• Detect bones, organs, or internal body structures\n• Provide medical imaging or diagnosis\n• Offer any scientifically accurate information about the human body\n\nAny results shown are PURELY fictional visual effects with no medical validity whatsoever.'),

              const _Section('3. No Medical Reliance',
                  'You agree that you will NEVER use this App for medical self-diagnosis, diagnosis of others, health risk assessment, or any medical purpose. For any health concerns, consult a qualified and licensed healthcare professional.\n\nWe expressly disclaim any responsibility for use of this App for medical, health, or quasi-medical purposes.'),

              const _Section('4. User Responsibilities',
                  'By using the App, you agree to:\n\n• Use the App only for personal, non-commercial entertainment\n• Not use the App to deceive, harm, or mislead others about real health conditions\n• Not use the App for any illegal purpose\n• Be at least 13 years of age, or have parental consent if under 18\n• Comply with all applicable local laws and regulations\n• Obtain consent before taking photos of other people'),

              const _Section('5. Intellectual Property',
                  'The App, including its design, code, graphics, animations, and all content, is the intellectual property of the App developer. You are granted a limited, non-exclusive, non-transferable, revocable license to use the App for personal entertainment only.\n\nYou may not:\n• Copy, reproduce, or distribute the App\n• Reverse engineer or decompile the App\n• Create derivative works based on the App\n• Use the App\'s branding or content for commercial purposes'),

              const _Section('6. Disclaimer of Warranties',
                  'THE APP IS PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED. WE DO NOT WARRANT:\n\n• That the App will be uninterrupted or error-free\n• That the App is accurate, reliable, or suitable for any specific purpose\n• That any medical or health-related information would be provided (it is not)\n• That the App will meet your specific requirements\n\nYOU USE THE APP ENTIRELY AT YOUR OWN RISK.'),

              const _Section('7. Limitation of Liability',
                  'TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, WE SHALL NOT BE LIABLE FOR:\n\n• Any direct, indirect, incidental, special, or consequential damages\n• Any damages arising from reliance on App content for any purpose\n• Any loss of data, profit, goodwill, or other intangible losses\n• Any medical or health-related decisions made based on App results\n\nOUR TOTAL LIABILITY SHALL NOT EXCEED ZERO (0) USD, AS THE APP IS PROVIDED FREE OF CHARGE.'),

              const _Section('8. Advertising',
                  'The App displays advertisements provided by Google AdMob. By using the App, you consent to the display of advertisements and the collection of advertising-related data by AdMob as described in our Privacy Policy. We are not responsible for the content of third-party advertisements.'),

              const _Section('9. Modifications',
                  'We reserve the right to modify or discontinue the App at any time without notice. We may update these Terms of Use periodically. Continued use of the App after changes constitutes acceptance of the revised terms.'),

              const _Section('10. Governing Law',
                  'These Terms shall be governed by and construed in accordance with applicable laws. Any disputes arising shall be resolved through good-faith negotiation. If negotiation fails, disputes shall be subject to binding arbitration.'),

              const _Section('11. Contact',
                  'For questions about these Terms of Use, contact us:\n\nEmail: ${AppStrings.contactEmail}\n\nWe aim to respond to all inquiries within 30 business days.'),

              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.danger.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                ),
                child: const Text(
                  '⚠️ IMPORTANT: This app is for entertainment ONLY. It does NOT perform real X-ray scanning or provide medical information of any kind.',
                  style: TextStyle(
                      color: AppColors.danger,
                      fontSize: 12,
                      height: 1.6,
                      fontWeight: FontWeight.w500),
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
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.neonBlue,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            body,
            style: TextStyle(
                color: AppColors.textSecondary, fontSize: 13.sp, height: 1.7),
          ),
          Divider(color: const Color(0x2200D4FF), height: 28.h),
        ],
      ),
    );
  }
}
