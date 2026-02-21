import 'package:flutter/material.dart';
import '../core/constants.dart';

class AnimatedScanLine extends StatefulWidget {
  final double width;
  final double height;

  const AnimatedScanLine({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<AnimatedScanLine> createState() => _AnimatedScanLineState();
}

class _AnimatedScanLineState extends State<AnimatedScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _animation = Tween<double>(begin: -0.2, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _ScanLinePainter(progress: _animation.value),
        );
      },
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  final double progress;

  _ScanLinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final y = progress * size.height;
    if (y < 0 || y > size.height) return;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          AppColors.scanLine.withOpacity(0.85),
          Colors.white.withOpacity(0.4),
          AppColors.scanLine.withOpacity(0.85),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, y - 40, size.width, 80));

    // Glow line
    canvas.drawRect(Rect.fromLTWH(0, y - 2, size.width, 4), paint);

    // Sharp white center line
    final whitePaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), whitePaint);

    // Subtle area glow
    final areaPaint = Paint()
      ..color = AppColors.scanLine.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, y - 100, size.width, 100), areaPaint);
  }

  @override
  bool shouldRepaint(_ScanLinePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
