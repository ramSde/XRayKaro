import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'storage_service.dart';

class SoundService {
  /// Play scan sound effect
  static Future<void> playScanSound() async {
    if (!StorageService.soundEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  /// Play capture sound effect
  static Future<void> playCaptureSound() async {
    if (!StorageService.soundEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  /// Play success sound
  static Future<void> playSuccessSound() async {
    if (!StorageService.soundEnabled) return;
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  /// Haptic feedback for button press
  static Future<void> hapticLight() async {
    if (!StorageService.soundEnabled) return;
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Error with haptic: $e');
    }
  }

  /// Haptic feedback for medium impact
  static Future<void> hapticMedium() async {
    if (!StorageService.soundEnabled) return;
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('Error with haptic: $e');
    }
  }

  /// Haptic feedback for heavy impact
  static Future<void> hapticHeavy() async {
    if (!StorageService.soundEnabled) return;
    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint('Error with haptic: $e');
    }
  }
}
