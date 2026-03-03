import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:gal/gal.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppUtils {
  /// Saves image bytes to the gallery using gal package
  static Future<String?> saveImageToGallery(Uint8List imageBytes,
      {String? fileName}) async {
    try {
      final name = fileName ?? 'xray_scan_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Save to temporary directory first
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$name');
      await tempFile.writeAsBytes(imageBytes);
      
      // Save to gallery using gal
      await Gal.putImage(tempFile.path);
      
      // Clean up temp file
      await tempFile.delete();
      
      return 'Scan saved successfully';
    } catch (e) {
      debugPrint('Error saving image: $e');
      return null;
    }
  }

  /// Apply a blue X-ray tint and skeleton effect to an image
  static Future<Uint8List?> applyXrayEffect(Uint8List imageBytes) async {
    try {
      final original = img.decodeImage(imageBytes);
      if (original == null) return null;

      // Convert to grayscale first
      final grayscale = img.grayscale(original);

      // Apply blue tint
      final tinted = img.Image(
        width: grayscale.width,
        height: grayscale.height,
      );

      for (int y = 0; y < grayscale.height; y++) {
        for (int x = 0; x < grayscale.width; x++) {
          final pixel = grayscale.getPixel(x, y);
          final lum = img.getLuminance(pixel).toInt();
          // Blue X-ray tint: darken reds/greens, keep blues bright
          final r = (lum * 0.3).clamp(0, 255).toInt();
          final g = (lum * 0.5).clamp(0, 255).toInt();
          final b = (lum * 1.2).clamp(0, 255).toInt();
          tinted.setPixelRgba(x, y, r, g, b, 255);
        }
      }

      return Uint8List.fromList(img.encodeJpg(tinted, quality: 90));
    } catch (e) {
      debugPrint('Error applying xray effect: $e');
      return null;
    }
  }

  /// Show a snackbar message
  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? const Color(0xFFFF3D71) : const Color(0xFF00D4FF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Format file size for display
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
