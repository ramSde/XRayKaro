import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../l10n/app_localizations.dart';
import '../core/constants.dart';
import '../services/storage_service.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  bool _accepted = false;

  void _proceed() async {
    await StorageService.acceptDisclaimer();
    await StorageService.acceptPrivacy();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              children: [
                const Spacer(),
                
                // Icon
                Text('💀', style: TextStyle(fontSize: 80.sp)),
                SizedBox(height: 24.h),
                
                // Title
                ShaderMask(
                  shaderCallback: (rect) => AppColors.neonGradient.createShader(rect),
                  child: Text(
                    l10n.appTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                
                Text(
                  l10n.appSubtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                ),
                
                SizedBox(height: 40.h),
                
                // Simple disclaimer
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.neonBlue, size: 32.sp),
                      SizedBox(height: 12.h),
                      Text(
                        l10n.entertainmentOnly,
                        style: TextStyle(
                          color: AppColors.neonBlue,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.disclaimerText,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24.h),
                
                // Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _accepted,
                      onChanged: (v) => setState(() => _accepted = v ?? false),
                      activeColor: AppColors.neonBlue,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _accepted = !_accepted),
                        child: Text(
                          l10n.iUnderstand,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const Spacer(),
                
                // Continue button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _accepted ? _proceed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonBlue,
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: Colors.grey.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      l10n.getStarted,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 12.h),
                
                // Legal links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/privacy'),
                      child: Text(
                        l10n.privacy,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    const Text('•', style: TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/terms'),
                      child: Text(
                        l10n.terms,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
