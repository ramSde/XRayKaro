import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../core/constants.dart';
import '../core/utils.dart';
import '../services/ad_service.dart';
import '../widgets/skeleton_overlay.dart';

class ResultScreen extends StatefulWidget {
  final String imagePath;

  const ResultScreen({super.key, required this.imagePath});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  bool _isSaving = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _fadeAnim =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    // Show interstitial after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) AdService.showInterstitialAd();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _saveImage() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      final bytes = await File(widget.imagePath).readAsBytes();
      final savedPath = await AppUtils.saveImageToGallery(bytes);

      if (mounted) {
        setState(() => _isSaving = false);
        AppUtils.showSnackBar(
          context,
          savedPath != null
              ? '✅ Image saved to gallery!'
              : '❌ Could not save image. Check storage permission.',
          isError: savedPath == null,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        AppUtils.showSnackBar(context, '❌ Error saving image.', isError: true);
      }
    }
  }

  Future<void> _shareImage() async {
    try {
      await Share.shareXFiles(
        [XFile(widget.imagePath)],
        text: AppStrings.shareText,
      );
    } catch (e) {
      if (mounted) {
        AppUtils.showSnackBar(context, '❌ Could not share image.', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Photo with X-ray tint ──────────────────────────────────────
            ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                0.3, 0.0, 0.0, 0, 5,  // Red
                0.0, 0.4, 0.0, 0, 10, // Green
                0.3, 0.2, 1.2, 0, 20, // Blue (boosted)
                0.0, 0.0, 0.0, 1, 0,  // Alpha
              ]),
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                cacheWidth: 1080, // Optimization for high-res images
                filterQuality: FilterQuality.medium,
              ),
            ),

            // ── Blue X-ray overlay tint ────────────────────────────────────
            Container(
              color: const Color(0x3300D4FF),
            ),

            // ── Skeleton overlay ──────────────────────────────────────────
            const Positioned.fill(
              child: SkeletonOverlay(
                animate: false,
                opacity: 0.7,
              ),
            ),

            // ── Scan line noise effect ────────────────────────────────────
            Positioned.fill(
              child: CustomPaint(painter: _NoisePainter()),
            ),

            // ── Top bar ───────────────────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      _CircleBtn(
                        icon: Icons.arrow_back_ios_rounded,
                        onTap: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.neonBlue.withValues(alpha: 0.5)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_fix_high,
                                color: AppColors.neonBlue, size: 14),
                            SizedBox(width: 6),
                            Text(
                              'Fun Skeleton Effect Applied!',
                              style: TextStyle(
                                  color: AppColors.neonBlue, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Bottom actions ────────────────────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Legal disclaimer
                      Text(
                        AppStrings.fullDisclaimer,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: _ActionBtn(
                              icon: Icons.camera_alt_rounded,
                              label: 'Scan Again',
                              color: AppColors.neonBlue,
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _ActionBtn(
                              icon: Icons.download_rounded,
                              label: _isSaving ? 'Saving...' : 'Save',
                              color: AppColors.success,
                              onTap: _isSaving ? () {} : _saveImage,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _ActionBtn(
                              icon: Icons.share_rounded,
                              label: 'Share 😂',
                              color: AppColors.neonPurple,
                              onTap: _shareImage,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.5),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple noise/static effect painter
class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.fill;

    // Draw subtle horizontal scan lines
    for (double y = 0; y < size.height; y += 4) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), paint);
    }
  }

  @override
  bool shouldRepaint(_NoisePainter old) => false;
}
