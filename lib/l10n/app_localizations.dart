import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('mr'),
    Locale('ta'),
    Locale('te')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'X-Ray Body Scanner'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Imaging Technology'**
  String get appSubtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @entertainmentOnly.
  ///
  /// In en, this message translates to:
  /// **'Entertainment Only'**
  String get entertainmentOnly;

  /// No description provided for @disclaimerText.
  ///
  /// In en, this message translates to:
  /// **'This app applies fun skeleton filters to photos. It\'s not a real X-ray scanner and has no medical purpose.'**
  String get disclaimerText;

  /// No description provided for @iUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand this is for fun only'**
  String get iUnderstand;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @startScan.
  ///
  /// In en, this message translates to:
  /// **'START SCAN'**
  String get startScan;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Scan History'**
  String get gallery;

  /// No description provided for @samples.
  ///
  /// In en, this message translates to:
  /// **'Scan Guide'**
  String get samples;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @scanAgain.
  ///
  /// In en, this message translates to:
  /// **'New Scan'**
  String get scanAgain;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get saving;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @imageSaved.
  ///
  /// In en, this message translates to:
  /// **'Scan saved to gallery!'**
  String get imageSaved;

  /// No description provided for @imageSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save scan. Check storage permission.'**
  String get imageSaveFailed;

  /// No description provided for @shareImageFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not share scan.'**
  String get shareImageFailed;

  /// No description provided for @noImagesYet.
  ///
  /// In en, this message translates to:
  /// **'No Scans Yet'**
  String get noImagesYet;

  /// No description provided for @takeFirstScan.
  ///
  /// In en, this message translates to:
  /// **'Perform your first scan to see results here'**
  String get takeFirstScan;

  /// No description provided for @startScanning.
  ///
  /// In en, this message translates to:
  /// **'Start Scanning'**
  String get startScanning;

  /// No description provided for @deleteImage.
  ///
  /// In en, this message translates to:
  /// **'Delete Scan?'**
  String get deleteImage;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @imageDeleted.
  ///
  /// In en, this message translates to:
  /// **'Scan deleted'**
  String get imageDeleted;

  /// No description provided for @sampleIdeas.
  ///
  /// In en, this message translates to:
  /// **'Scan Guide'**
  String get sampleIdeas;

  /// No description provided for @sampleDescription.
  ///
  /// In en, this message translates to:
  /// **'Recommended scanning techniques for optimal results'**
  String get sampleDescription;

  /// No description provided for @handScan.
  ///
  /// In en, this message translates to:
  /// **'Hand Scan'**
  String get handScan;

  /// No description provided for @handScanDesc.
  ///
  /// In en, this message translates to:
  /// **'Position hand flat against surface for clear bone structure'**
  String get handScanDesc;

  /// No description provided for @skullScan.
  ///
  /// In en, this message translates to:
  /// **'Skull Scan'**
  String get skullScan;

  /// No description provided for @skullScanDesc.
  ///
  /// In en, this message translates to:
  /// **'Face camera directly for optimal cranial imaging'**
  String get skullScanDesc;

  /// No description provided for @fullBody.
  ///
  /// In en, this message translates to:
  /// **'Full Body'**
  String get fullBody;

  /// No description provided for @fullBodyDesc.
  ///
  /// In en, this message translates to:
  /// **'Stand 2-3 meters away for complete skeletal scan'**
  String get fullBodyDesc;

  /// No description provided for @petScan.
  ///
  /// In en, this message translates to:
  /// **'Pet Scan'**
  String get petScan;

  /// No description provided for @petScanDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep subject still during scanning process'**
  String get petScanDesc;

  /// No description provided for @proTips.
  ///
  /// In en, this message translates to:
  /// **'Scanning Tips'**
  String get proTips;

  /// No description provided for @tipGoodLighting.
  ///
  /// In en, this message translates to:
  /// **'Use adequate lighting for best results'**
  String get tipGoodLighting;

  /// No description provided for @tipDifferentAngles.
  ///
  /// In en, this message translates to:
  /// **'Try different angles for comprehensive analysis'**
  String get tipDifferentAngles;

  /// No description provided for @tipShareFriends.
  ///
  /// In en, this message translates to:
  /// **'Share scans for comparison'**
  String get tipShareFriends;

  /// No description provided for @tipSaveFavorites.
  ///
  /// In en, this message translates to:
  /// **'Save important scans to history'**
  String get tipSaveFavorites;

  /// No description provided for @startScanningNow.
  ///
  /// In en, this message translates to:
  /// **'Begin Scanning'**
  String get startScanningNow;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @soundEffectsDesc.
  ///
  /// In en, this message translates to:
  /// **'Scan sounds & haptic feedback'**
  String get soundEffectsDesc;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose app language'**
  String get chooseLanguage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @purchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get purchases;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @restorePurchasesDesc.
  ///
  /// In en, this message translates to:
  /// **'Restore in-app purchases'**
  String get restorePurchasesDesc;

  /// No description provided for @noPurchases.
  ///
  /// In en, this message translates to:
  /// **'No purchases to restore.'**
  String get noPurchases;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'X-Ray Scanner v{version}'**
  String appVersion(Object version);

  /// No description provided for @entertainmentWarning.
  ///
  /// In en, this message translates to:
  /// **'For entertainment only. Not real X-ray.'**
  String get entertainmentWarning;

  /// No description provided for @supportEmail.
  ///
  /// In en, this message translates to:
  /// **'support@xrayscanner.app'**
  String get supportEmail;

  /// No description provided for @cameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Camera Access Required'**
  String get cameraPermission;

  /// No description provided for @cameraPermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Camera access is required for scanning functionality.\\nTap below to grant permission.'**
  String get cameraPermissionDesc;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @readDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Read Full Disclaimer'**
  String get readDisclaimer;

  /// No description provided for @disclaimerRead.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer Read'**
  String get disclaimerRead;

  /// No description provided for @acceptContinue.
  ///
  /// In en, this message translates to:
  /// **'Accept & Continue'**
  String get acceptContinue;

  /// No description provided for @pleaseReadFirst.
  ///
  /// In en, this message translates to:
  /// **'Please read the full disclaimer first'**
  String get pleaseReadFirst;

  /// No description provided for @scanningInProgress.
  ///
  /// In en, this message translates to:
  /// **'Scanning in progress...'**
  String get scanningInProgress;

  /// No description provided for @calibratingSensors.
  ///
  /// In en, this message translates to:
  /// **'Calibrating sensors...'**
  String get calibratingSensors;

  /// No description provided for @analyzingStructure.
  ///
  /// In en, this message translates to:
  /// **'Analyzing bone structure...'**
  String get analyzingStructure;

  /// No description provided for @processingImage.
  ///
  /// In en, this message translates to:
  /// **'Processing image data...'**
  String get processingImage;

  /// No description provided for @scanComplete.
  ///
  /// In en, this message translates to:
  /// **'Scan Complete'**
  String get scanComplete;

  /// No description provided for @scanningActive.
  ///
  /// In en, this message translates to:
  /// **'Scanning Active'**
  String get scanningActive;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'bn',
        'en',
        'es',
        'hi',
        'mr',
        'ta',
        'te'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
