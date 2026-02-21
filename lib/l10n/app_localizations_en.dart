// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Xray Fun Camera';

  @override
  String get disclaimerTitle => 'Disclaimer';

  @override
  String get disclaimerShort => 'This app provides simulated X-ray visuals for entertainment only.';

  @override
  String get disclaimerRead => 'Read';

  @override
  String get disclaimerAccept => 'Accept Disclaimer & Privacy Policy';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get terms => 'Terms & Conditions';

  @override
  String get forceUpdateTitle => 'Update Required';

  @override
  String get forceUpdateMessage => 'A new version of the app is available. Please update to continue.';

  @override
  String get updateButton => 'Update Now';
}
