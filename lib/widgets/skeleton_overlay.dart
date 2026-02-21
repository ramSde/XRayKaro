import 'package:flutter/material.dart';
import '../core/constants.dart';

/// Widget that overlays a drawn skeleton on top of an image
class SkeletonOverlay extends StatefulWidget {
  final bool animate;
  final double opacity;
  final Color tintColor;

  const SkeletonOverlay({
    super.key,
    this.animate = true,
    this.opacity = 0.6,
    this.tintColor = AppColors.neonBlue,
  });

  @override
  State<SkeletonOverlay> createState() => _SkeletonOverlayState();
}

class _SkeletonOverlayState extends State<SkeletonOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..repeat(reverse: true);
      _pulseAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
    } else {
      _controller = AnimationController(vsync: this);
      _pulseAnim = const AlwaysStoppedAnimation(0.75);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnim,
      builder: (ctx, _) {
        return CustomPaint(
          painter: _SkeletonPainter(
            opacity: widget.opacity * _pulseAnim.value,
            color: widget.tintColor,
          ),
        );
      },
    );
  }
}

class _SkeletonPainter extends CustomPainter {
  final double opacity;
  final Color color;

  _SkeletonPainter({required this.opacity, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, opacity * 3);

    final w = size.width;
    final h = size.height;

    final cx = w / 2;

    // ─── Skull ────────────────────────────────────────────────────────────────
    canvas.drawOval(
        Rect.fromCenter(center: Offset(cx, h * 0.08), width: w * 0.18, height: h * 0.12), paint);
    // Eye sockets
    canvas.drawCircle(Offset(cx - w * 0.04, h * 0.075), w * 0.025, paint);
    canvas.drawCircle(Offset(cx + w * 0.04, h * 0.075), w * 0.025, paint);
    // Jaw
    canvas.drawArc(
        Rect.fromCenter(center: Offset(cx, h * 0.1), width: w * 0.14, height: h * 0.06),
        0.2, 2.7, false, paint);

    // ─── Spine ────────────────────────────────────────────────────────────────
    for (int i = 0; i < 12; i++) {
      final y = h * 0.15 + i * (h * 0.04);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(cx, y), width: w * 0.06, height: h * 0.025),
          const Radius.circular(3),
        ),
        paint,
      );
      // Ribs (alternating)
      if (i >= 1 && i <= 6) {
        // Left rib
        final path1 = Path();
        path1.moveTo(cx - w * 0.03, y);
        path1.quadraticBezierTo(cx - w * 0.15, y + h * 0.01, cx - w * 0.18, y + h * 0.03);
        canvas.drawPath(path1, paint);
        // Right rib
        final path2 = Path();
        path2.moveTo(cx + w * 0.03, y);
        path2.quadraticBezierTo(cx + w * 0.15, y + h * 0.01, cx + w * 0.18, y + h * 0.03);
        canvas.drawPath(path2, paint);
      }
    }

    // ─── Pelvis ───────────────────────────────────────────────────────────────
    final pelvisY = h * 0.62;
    canvas.drawOval(
        Rect.fromCenter(center: Offset(cx, pelvisY), width: w * 0.25, height: h * 0.07), paint);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(cx, pelvisY), width: w * 0.12, height: h * 0.04), paint);

    // ─── Left Leg ─────────────────────────────────────────────────────────────
    // Femur
    final legTopY = pelvisY + h * 0.04;
    canvas.drawLine(Offset(cx - w * 0.08, legTopY), Offset(cx - w * 0.1, h * 0.80), paint);
    // Tibia
    canvas.drawLine(Offset(cx - w * 0.1, h * 0.80), Offset(cx - w * 0.09, h * 0.95), paint);
    // Fibula
    canvas.drawLine(Offset(cx - w * 0.1, h * 0.80), Offset(cx - w * 0.12, h * 0.95), paint);
    // Foot
    canvas.drawLine(Offset(cx - w * 0.09, h * 0.95), Offset(cx - w * 0.18, h * 0.97), paint);

    // ─── Right Leg ────────────────────────────────────────────────────────────
    canvas.drawLine(Offset(cx + w * 0.08, legTopY), Offset(cx + w * 0.1, h * 0.80), paint);
    canvas.drawLine(Offset(cx + w * 0.1, h * 0.80), Offset(cx + w * 0.09, h * 0.95), paint);
    canvas.drawLine(Offset(cx + w * 0.1, h * 0.80), Offset(cx + w * 0.12, h * 0.95), paint);
    canvas.drawLine(Offset(cx + w * 0.09, h * 0.95), Offset(cx + w * 0.18, h * 0.97), paint);

    // ─── Shoulders & Arms ─────────────────────────────────────────────────────
    const shoulderYRelation = 0.20;
    final shoulderY = h * shoulderYRelation;
    // Collar bones
    canvas.drawLine(Offset(cx - w * 0.12, shoulderY), Offset(cx, shoulderY - h * 0.01), paint);
    canvas.drawLine(Offset(cx + w * 0.12, shoulderY), Offset(cx, shoulderY - h * 0.01), paint);

    // Left arm - humerus
    canvas.drawLine(Offset(cx - w * 0.12, shoulderY), Offset(cx - w * 0.20, h * 0.44), paint);
    // Left forearm
    canvas.drawLine(Offset(cx - w * 0.20, h * 0.44), Offset(cx - w * 0.18, h * 0.60), paint);
    canvas.drawLine(Offset(cx - w * 0.20, h * 0.44), Offset(cx - w * 0.23, h * 0.60), paint);
    // Left hand
    canvas.drawLine(Offset(cx - w * 0.19, h * 0.60), Offset(cx - w * 0.19, h * 0.64), paint);
    canvas.drawLine(Offset(cx - w * 0.22, h * 0.60), Offset(cx - w * 0.22, h * 0.64), paint);
    canvas.drawLine(Offset(cx - w * 0.24, h * 0.60), Offset(cx - w * 0.25, h * 0.63), paint);

    // Right arm
    canvas.drawLine(Offset(cx + w * 0.12, shoulderY), Offset(cx + w * 0.20, h * 0.44), paint);
    canvas.drawLine(Offset(cx + w * 0.20, h * 0.44), Offset(cx + w * 0.18, h * 0.60), paint);
    canvas.drawLine(Offset(cx + w * 0.20, h * 0.44), Offset(cx + w * 0.23, h * 0.60), paint);
    canvas.drawLine(Offset(cx + w * 0.19, h * 0.60), Offset(cx + w * 0.19, h * 0.64), paint);
    canvas.drawLine(Offset(cx + w * 0.22, h * 0.60), Offset(cx + w * 0.22, h * 0.64), paint);
    canvas.drawLine(Offset(cx + w * 0.24, h * 0.60), Offset(cx + w * 0.25, h * 0.63), paint);
  }

  @override
  bool shouldRepaint(_SkeletonPainter old) => old.opacity != opacity;
}
