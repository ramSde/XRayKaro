import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/constants.dart';

enum SkeletonStyle {
  full,      // Full body skeleton
  skull,     // Just skull
  hands,     // Hand bones
  ribcage,   // Ribcage focus
}

/// Widget that overlays a drawn skeleton on top of an image
class SkeletonOverlay extends StatefulWidget {
  final bool animate;
  final double opacity;
  final Color tintColor;
  final SkeletonStyle style;

  const SkeletonOverlay({
    super.key,
    this.animate = true,
    this.opacity = 0.6,
    this.tintColor = AppColors.neonBlue,
    this.style = SkeletonStyle.full,
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
      builder: (context, child) {
        return CustomPaint(
          painter: _SkeletonPainter(
            opacity: widget.opacity * _pulseAnim.value,
            color: widget.tintColor,
            style: widget.style,
          ),
          child: Container(),
        );
      },
    );
  }
}

class _SkeletonPainter extends CustomPainter {
  final double opacity;
  final Color color;
  final SkeletonStyle style;

  _SkeletonPainter({
    required this.opacity,
    required this.color,
    required this.style,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.3)
      ..style = PaintingStyle.fill;

    switch (style) {
      case SkeletonStyle.full:
        _drawFullSkeleton(canvas, size, paint, fillPaint);
        break;
      case SkeletonStyle.skull:
        _drawSkull(canvas, size, paint, fillPaint);
        break;
      case SkeletonStyle.hands:
        _drawHands(canvas, size, paint, fillPaint);
        break;
      case SkeletonStyle.ribcage:
        _drawRibcage(canvas, size, paint, fillPaint);
        break;
    }
  }

  void _drawFullSkeleton(Canvas canvas, Size size, Paint paint, Paint fillPaint) {
    final centerX = size.width / 2;
    final headY = size.height * 0.15;
    final neckY = size.height * 0.22;
    final shoulderY = size.height * 0.28;
    final chestY = size.height * 0.45;
    final waistY = size.height * 0.55;
    final hipY = size.height * 0.60;
    final kneeY = size.height * 0.75;
    final footY = size.height * 0.92;

    // Skull
    canvas.drawCircle(Offset(centerX, headY), size.width * 0.08, paint);
    canvas.drawCircle(Offset(centerX - 15, headY - 5), 8, fillPaint); // Eye
    canvas.drawCircle(Offset(centerX + 15, headY - 5), 8, fillPaint); // Eye

    // Spine
    canvas.drawLine(Offset(centerX, neckY), Offset(centerX, hipY), paint);

    // Ribcage
    for (int i = 0; i < 6; i++) {
      final y = shoulderY + (i * (chestY - shoulderY) / 6);
      final width = size.width * 0.12 - (i * 3);
      canvas.drawArc(
        Rect.fromCenter(center: Offset(centerX, y), width: width * 2, height: 20),
        math.pi,
        math.pi,
        false,
        paint,
      );
    }

    // Shoulders
    canvas.drawLine(
      Offset(centerX - size.width * 0.15, shoulderY),
      Offset(centerX + size.width * 0.15, shoulderY),
      paint,
    );

    // Arms
    canvas.drawLine(
      Offset(centerX - size.width * 0.15, shoulderY),
      Offset(centerX - size.width * 0.18, waistY),
      paint,
    );
    canvas.drawLine(
      Offset(centerX + size.width * 0.15, shoulderY),
      Offset(centerX + size.width * 0.18, waistY),
      paint,
    );

    // Pelvis
    canvas.drawLine(
      Offset(centerX - size.width * 0.08, hipY),
      Offset(centerX + size.width * 0.08, hipY),
      paint,
    );

    // Legs
    canvas.drawLine(
      Offset(centerX - size.width * 0.05, hipY),
      Offset(centerX - size.width * 0.06, kneeY),
      paint,
    );
    canvas.drawLine(
      Offset(centerX + size.width * 0.05, hipY),
      Offset(centerX + size.width * 0.06, kneeY),
      paint,
    );
    canvas.drawLine(
      Offset(centerX - size.width * 0.06, kneeY),
      Offset(centerX - size.width * 0.05, footY),
      paint,
    );
    canvas.drawLine(
      Offset(centerX + size.width * 0.06, kneeY),
      Offset(centerX + size.width * 0.05, footY),
      paint,
    );
  }

  void _drawSkull(Canvas canvas, Size size, Paint paint, Paint fillPaint) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.25;

    // Skull outline
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    
    // Eyes
    canvas.drawCircle(Offset(centerX - radius * 0.4, centerY - radius * 0.2), radius * 0.25, fillPaint);
    canvas.drawCircle(Offset(centerX + radius * 0.4, centerY - radius * 0.2), radius * 0.25, fillPaint);
    
    // Nose
    final nosePath = Path();
    nosePath.moveTo(centerX, centerY + radius * 0.1);
    nosePath.lineTo(centerX - radius * 0.15, centerY + radius * 0.3);
    nosePath.lineTo(centerX + radius * 0.15, centerY + radius * 0.3);
    nosePath.close();
    canvas.drawPath(nosePath, fillPaint);
    
    // Teeth
    for (int i = 0; i < 8; i++) {
      final x = centerX - radius * 0.5 + (i * radius * 0.14);
      final y = centerY + radius * 0.6;
      canvas.drawRect(Rect.fromLTWH(x, y, radius * 0.1, radius * 0.15), paint);
    }
  }

  void _drawHands(Canvas canvas, Size size, Paint paint, Paint fillPaint) {
    _drawHand(canvas, size.width * 0.25, size.height * 0.5, paint, false);
    _drawHand(canvas, size.width * 0.75, size.height * 0.5, paint, true);
  }

  void _drawHand(Canvas canvas, double x, double y, Paint paint, bool flip) {
    final direction = flip ? -1 : 1;
    
    // Palm
    canvas.drawCircle(Offset(x, y), 30, paint);
    
    // Fingers
    for (int i = 0; i < 5; i++) {
      final angle = (i - 2) * 0.3;
      final fingerX = x + (math.cos(angle) * 40 * direction);
      final fingerY = y - (math.sin(angle) * 40).abs();
      
      // Finger bones
      canvas.drawLine(Offset(x, y), Offset(fingerX, fingerY), paint);
      canvas.drawLine(
        Offset(fingerX, fingerY),
        Offset(fingerX + (math.cos(angle) * 25 * direction), fingerY - 25),
        paint,
      );
    }
  }

  void _drawRibcage(Canvas canvas, Size size, Paint paint, Paint fillPaint) {
    final centerX = size.width / 2;
    final topY = size.height * 0.3;
    final bottomY = size.height * 0.6;

    // Spine
    canvas.drawLine(Offset(centerX, topY), Offset(centerX, bottomY), paint);

    // Ribs
    for (int i = 0; i < 8; i++) {
      final y = topY + (i * (bottomY - topY) / 8);
      final width = size.width * 0.15 - (i * 2);
      
      canvas.drawArc(
        Rect.fromCenter(center: Offset(centerX, y), width: width * 2, height: 25),
        math.pi,
        math.pi,
        false,
        paint,
      );
    }

    // Sternum
    canvas.drawLine(
      Offset(centerX, topY),
      Offset(centerX, topY + (bottomY - topY) * 0.7),
      paint..strokeWidth = 5,
    );
  }

  @override
  bool shouldRepaint(_SkeletonPainter old) =>
      old.opacity != opacity || old.color != color || old.style != style;
}
