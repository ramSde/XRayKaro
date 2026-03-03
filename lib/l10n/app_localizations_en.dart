// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'X-Ray Body Scanner';

  @override
  String get appSubtitle => 'Advanced Imaging Technology';

  @override
  String get getStarted => 'Get Started';

  @override
  String get entertainmentOnly => 'Entertainment Only';

  @override
  String get disclaimerText =>
      'This app applies fun skeleton filters to photos. It\'s not a real X-ray scanner and has no medical purpose.';

  @override
  String get iUnderstand => 'I understand this is for fun only';

  @override
  String get privacy => 'Privacy';

  @override
  String get terms => 'Terms';

  @override
  String get startScan => 'START SCAN';

  @override
  String get gallery => 'Scan History';

  @override
  String get samples => 'Scan Guide';

  @override
  String get settings => 'Settings';

  @override
  String get shareApp => 'Share App';

  @override
  String get rateApp => 'Rate App';

  @override
  String get scanAgain => 'New Scan';

  @override
  String get save => 'Save';

  @override
  String get saving => 'Processing...';

  @override
  String get share => 'Share';

  @override
  String get imageSaved => 'Scan saved to gallery!';

  @override
  String get imageSaveFailed =>
      'Could not save scan. Check storage permission.';

  @override
  String get shareImageFailed => 'Could not share scan.';

  @override
  String get noImagesYet => 'No Scans Yet';

  @override
  String get takeFirstScan => 'Perform your first scan to see results here';

  @override
  String get startScanning => 'Start Scanning';

  @override
  String get deleteImage => 'Delete Scan?';

  @override
  String get deleteConfirm => 'This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get imageDeleted => 'Scan deleted';

  @override
  String get sampleIdeas => 'Scan Guide';

  @override
  String get sampleDescription =>
      'Recommended scanning techniques for optimal results';

  @override
  String get handScan => 'Hand Scan';

  @override
  String get handScanDesc =>
      'Position hand flat against surface for clear bone structure';

  @override
  String get skullScan => 'Skull Scan';

  @override
  String get skullScanDesc =>
      'Face camera directly for optimal cranial imaging';

  @override
  String get fullBody => 'Full Body';

  @override
  String get fullBodyDesc => 'Stand 2-3 meters away for complete skeletal scan';

  @override
  String get petScan => 'Pet Scan';

  @override
  String get petScanDesc => 'Keep subject still during scanning process';

  @override
  String get proTips => 'Scanning Tips';

  @override
  String get tipGoodLighting => 'Use adequate lighting for best results';

  @override
  String get tipDifferentAngles =>
      'Try different angles for comprehensive analysis';

  @override
  String get tipShareFriends => 'Share scans for comparison';

  @override
  String get tipSaveFavorites => 'Save important scans to history';

  @override
  String get startScanningNow => 'Begin Scanning';

  @override
  String get preferences => 'Preferences';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get soundEffectsDesc => 'Scan sounds & haptic feedback';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose app language';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get purchases => 'Purchases';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get restorePurchasesDesc => 'Restore in-app purchases';

  @override
  String get noPurchases => 'No purchases to restore.';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get disclaimer => 'Disclaimer';

  @override
  String appVersion(Object version) {
    return 'X-Ray Scanner v$version';
  }

  @override
  String get entertainmentWarning => 'For entertainment only. Not real X-ray.';

  @override
  String get supportEmail => 'support@xrayscanner.app';

  @override
  String get cameraPermission => 'Camera Access Required';

  @override
  String get cameraPermissionDesc =>
      'Camera access is required for scanning functionality.\\nTap below to grant permission.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get goBack => 'Go Back';

  @override
  String get readDisclaimer => 'Read Full Disclaimer';

  @override
  String get disclaimerRead => 'Disclaimer Read';

  @override
  String get acceptContinue => 'Accept & Continue';

  @override
  String get pleaseReadFirst => 'Please read the full disclaimer first';

  @override
  String get scanningInProgress => 'Scanning in progress...';

  @override
  String get calibratingSensors => 'Calibrating sensors...';

  @override
  String get analyzingStructure => 'Analyzing bone structure...';

  @override
  String get processingImage => 'Processing image data...';

  @override
  String get scanComplete => 'Scan Complete';

  @override
  String get scanningActive => 'Scanning Active';
}
