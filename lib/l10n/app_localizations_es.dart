// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Cámara de Rayos X Divertida';

  @override
  String get disclaimerTitle => 'Aviso legal';

  @override
  String get disclaimerShort => 'Esta aplicación proporciona imágenes simuladas de rayos X solo para entretenimiento.';

  @override
  String get disclaimerRead => 'Leer';

  @override
  String get disclaimerAccept => 'Aceptar aviso legal y política de privacidad';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get terms => 'Términos y condiciones';

  @override
  String get forceUpdateTitle => 'Actualización requerida';

  @override
  String get forceUpdateMessage => 'Hay una nueva versión de la aplicación disponible. Por favor actualice para continuar.';

  @override
  String get updateButton => 'Actualizar ahora';
}
