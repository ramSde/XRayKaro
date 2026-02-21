import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants.dart';
import '../services/storage_service.dart';
import '../widgets/primary_button.dart';

/// Shows on first launch only. User must tap "Read Disclaimer" first,
/// then accept both disclaimer and privacy policy to proceed.
class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen>
    with TickerProviderStateMixin {
  bool _disclaimerRead = false;
  bool _disclaimerAccepted = false;
  bool _privacyAccepted = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _openDisclaimerReadScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const _DisclaimerReadScreen(),
      ),
    ).then((_) {
      if (mounted) setState(() => _disclaimerRead = true);
    });
  }

  void _proceed() async {
    await StorageService.acceptDisclaimer();
    await StorageService.acceptPrivacy();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  bool get _canProceed => _disclaimerRead && _disclaimerAccepted && _privacyAccepted;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Center(
                    child: Column(
                      children: [
                        Text('⚖️', style: TextStyle(fontSize: 48.sp)),
                        SizedBox(height: 12.h),
                        ShaderMask(
                          shaderCallback: (rect) =>
                              AppColors.neonGradient.createShader(rect),
                          child: Text(
                            'Legal Notice',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Before you start having fun 🎉',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Quick summary card
                  const _InfoCard(
                    icon: '💀',
                    title: 'Entertainment Only',
                    body:
                        'This is a fun prank/filter app. It does NOT perform real X-ray scanning or any medical imaging.',
                  ),

                  const SizedBox(height: 12),

                  const _InfoCard(
                    icon: '📷',
                    title: 'Camera Usage',
                    body:
                        'Camera is used locally to apply the skeleton filter. No photos are uploaded to any server.',
                  ),

                  const SizedBox(height: 20),

                  // Read Disclaimer button
                  _ReadButton(
                    icon: Icons.description_outlined,
                    label: 'Read Full Disclaimer',
                    isRead: _disclaimerRead,
                    onTap: _openDisclaimerReadScreen,
                  ),

                  const SizedBox(height: 20),

                  // Checkboxes (only enabled after reading)
                  _CheckRow(
                    enabled: _disclaimerRead,
                    checked: _disclaimerAccepted,
                    label:
                        'I understand this app is for entertainment only and does not provide real X-ray or medical services.',
                    onChanged: _disclaimerRead
                        ? (v) => setState(() => _disclaimerAccepted = v ?? false)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _CheckRow(
                    enabled: _disclaimerRead,
                    checked: _privacyAccepted,
                    label: 'I have read and agree to the Privacy Policy and Terms of Use.',
                    onChanged: _disclaimerRead
                        ? (v) => setState(() => _privacyAccepted = v ?? false)
                        : null,
                    onLinkTap: () => Navigator.pushNamed(context, '/privacy'),
                    linkText: 'Privacy Policy',
                  ),

                  const Spacer(),

                  // Accept & Continue button
                  if (!_disclaimerRead)
                    Center(
                      child: Text(
                        'Please read the full disclaimer first ⬆️',
                        style: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.6),
                            fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  const SizedBox(height: 12),

                  AnimatedOpacity(
                    opacity: _canProceed ? 1.0 : 0.35,
                    duration: const Duration(milliseconds: 300),
                    child: PrimaryButton(
                      text: '✅ Accept & Continue',
                      onPressed: _canProceed ? _proceed : null,
                      height: 56,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Info Card ────────────────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String body;

  const _InfoCard({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: TextStyle(fontSize: 22.sp)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.neonBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  body,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Read Button ──────────────────────────────────────────────────────────────
class _ReadButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isRead;
  final VoidCallback onTap;

  const _ReadButton({
    required this.icon,
    required this.label,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
        decoration: BoxDecoration(
          color: isRead
              ? AppColors.success.withOpacity(0.12)
              : AppColors.neonBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isRead 
                ? AppColors.success.withOpacity(0.6) 
                : AppColors.neonBlue.withOpacity(0.5),
            width: 1.5.r,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isRead ? Icons.check_circle_rounded : icon,
              color: isRead ? AppColors.success : AppColors.neonBlue,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isRead ? 'Disclaimer Read ✓' : label,
                style: TextStyle(
                  color: isRead ? AppColors.success : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            if (!isRead)
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: AppColors.neonBlue.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}

// ─── Checkbox Row ─────────────────────────────────────────────────────────────
class _CheckRow extends StatelessWidget {
  final bool enabled;
  final bool checked;
  final String label;
  final ValueChanged<bool?>? onChanged;
  final String? linkText;
  final VoidCallback? onLinkTap;

  const _CheckRow({
    required this.enabled,
    required this.checked,
    required this.label,
    this.onChanged,
    this.linkText,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: checked,
          onChanged: enabled ? onChanged : null,
          activeColor: AppColors.neonBlue,
          side: BorderSide(
            color: enabled 
                ? AppColors.neonBlue.withOpacity(0.6) 
                : Colors.grey.withOpacity(0.3),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: enabled 
                      ? AppColors.textSecondary 
                      : AppColors.textSecondary.withOpacity(0.3),
                  fontSize: 13,
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: label),
                  if (linkText != null && onLinkTap != null) ...[
                    const TextSpan(text: ' '),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: onLinkTap,
                        child: Text(
                          linkText!,
                          style: const TextStyle(
                            color: AppColors.neonBlue,
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Full Disclaimer Read Screen ──────────────────────────────────────────────
class _DisclaimerReadScreen extends StatelessWidget {
  const _DisclaimerReadScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Entertainment Disclaimer'),
        backgroundColor: AppColors.cardBg,
        foregroundColor: AppColors.neonBlue,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text('⚠️', style: TextStyle(fontSize: 40))),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Entertainment Disclaimer',
                  style: TextStyle(
                    color: AppColors.neonBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const _Section('1. Entertainment Purpose Only',
                  'This application, "Xray Fun Camera – Skeleton Prank Simulator," is designed and intended SOLELY for entertainment, fun, and amusement purposes. It is a novelty/prank simulator application.'),
              const _Section('2. No Real X-Ray Technology',
                  'This app does NOT use, contain, or perform real X-ray scanning, radiography, imaging, bone detection, organ detection, or any medical diagnostic technology whatsoever. The "skeleton" effect is a pre-designed graphic overlay applied to photos purely for fun.'),
              const _Section('3. No Medical Accuracy',
                  'Results shown in this app have absolutely no medical accuracy, validity, or scientific basis. No real bones, organs, tissue, or internal body structures are detected, identified, or displayed.'),
              const _Section('4. No Medical Diagnosis',
                  'This app must NOT be used for medical self-diagnosis, diagnosis of others, detection of injuries, fractures, diseases, or any health-related assessment. For any medical concerns, always consult a qualified healthcare professional.'),
              const _Section('5. Not for Children Under 13',
                  'This app is not intended for use by children under 13 years of age without parental supervision. Parental guidance is advised.'),
              const _Section('6. Prank Use Responsibility',
                  'The app may be used for harmless fun and pranks. Users are responsible for using the app appropriately and ethically. Do not use this app to deceive or mislead anyone about real health conditions.'),
              const _Section('7. No Liability',
                  'The developers and publishers of this app shall not be held liable for any misuse, misinterpretation, or harm resulting from use of this application. Use at your own discretion.'),
              const _Section('8. Accepted Safe Terminology',
                  'Only the following terms apply to this app: "fun Xray effect", "skeleton filter", "prank simulator", "skeleton overlay", "fun prank camera". This is a novelty entertainment product only.'),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neonBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neonBlue.withOpacity(0.3)),
                ),
                child: const Text(
                  '✅ By using this app you acknowledge and agree that this is a fun entertainment app only, with no real X-ray or medical capabilities.',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check_circle_outlined),
                  label: const Text('I\'ve Read the Disclaimer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonBlue,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
      padding: const EdgeInsets.only(bottom: 18),
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
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 13, height: 1.6),
          ),
          const Divider(color: Color(0x2200D4FF), height: 24),
        ],
      ),
    );
  }
}
