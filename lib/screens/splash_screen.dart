import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants.dart';
import '../services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    _glowAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: const Interval(0.5, 1.0),
      ),
    );

    _scaleController.forward();

    Future.delayed(const Duration(milliseconds: 2500), _navigateNext);
  }

  void _navigateNext() {
    if (!mounted) return;
    final bool disclaimerAccepted = StorageService.disclaimerAccepted;
    Navigator.pushReplacementNamed(
      context,
      disclaimerAccepted ? '/home' : '/disclaimer',
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF050B18),
              Color(0xFF070F22),
              Color(0xFF050B18),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Glow + Scale animated icon ────────────────────────────────
              AnimatedBuilder(
                animation: Listenable.merge([_scaleAnim, _glowAnim]),
                builder: (ctx, _) {
                  return Transform.scale(
                    scale: _scaleAnim.value,
                    child: Container(
                      width: 160.r,
                      height: 160.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonBlue
                                .withOpacity(0.5 * _glowAnim.value),
                            blurRadius: 60.r * _glowAnim.value,
                            spreadRadius: 20.r * _glowAnim.value,
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.neonBlue.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                          border: Border.all(
                            color: AppColors.neonBlue
                                .withOpacity(0.8 * _glowAnim.value),
                            width: 2.r,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '💀',
                            style: TextStyle(fontSize: 80.sp),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ── App name ──────────────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) =>
                          AppColors.neonGradient.createShader(rect),
                      child: Text(
                        'Xray Fun Camera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Skeleton Prank Simulator',
                      style: TextStyle(
                        color: AppColors.neonBlue.withValues(alpha: 0.8),
                        fontSize: 14.sp,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // ── Loading bar ───────────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    backgroundColor:
                        AppColors.neonBlue.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.neonBlue.withOpacity(0.8),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // ── Legal notice ──────────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    '⚠️ For entertainment only. Not real X-ray.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0x8888AACE),
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
