// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Escáner Corporal de Rayos X';

  @override
  String get appSubtitle => 'Tecnología de Imagen Avanzada';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get entertainmentOnly => 'Solo Entretenimiento';

  @override
  String get disclaimerText =>
      'Esta aplicación aplica filtros de esqueleto divertidos a las fotos. No es un escáner de rayos X real y no tiene ningún propósito médico.';

  @override
  String get iUnderstand => 'Entiendo que esto es solo por diversión';

  @override
  String get privacy => 'Privacidad';

  @override
  String get terms => 'Términos';

  @override
  String get startScan => 'INICIAR ESCANEO';

  @override
  String get gallery => 'Historial de Escaneos';

  @override
  String get samples => 'Guía de Escaneo';

  @override
  String get settings => 'Ajustes';

  @override
  String get shareApp => 'Compartir App';

  @override
  String get rateApp => 'Calificar App';

  @override
  String get scanAgain => 'Nuevo Escaneo';

  @override
  String get save => 'Guardar';

  @override
  String get saving => 'Procesando...';

  @override
  String get share => 'Compartir';

  @override
  String get imageSaved => '¡Escaneo guardado en la galería!';

  @override
  String get imageSaveFailed =>
      'No se pudo guardar el escaneo. Verifica el permiso de almacenamiento.';

  @override
  String get shareImageFailed => 'No se pudo compartir el escaneo.';

  @override
  String get noImagesYet => 'Aún No Hay Escaneos';

  @override
  String get takeFirstScan =>
      'Realiza tu primer escaneo para ver los resultados aquí';

  @override
  String get startScanning => 'Comenzar a Escanear';

  @override
  String get deleteImage => '¿Eliminar Escaneo?';

  @override
  String get deleteConfirm => 'Esta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get imageDeleted => 'Escaneo eliminado';

  @override
  String get sampleIdeas => 'Guía de Escaneo';

  @override
  String get sampleDescription =>
      'Técnicas de escaneo recomendadas para resultados óptimos';

  @override
  String get handScan => 'Escaneo de Mano';

  @override
  String get handScanDesc =>
      'Coloca la mano plana contra la superficie para una estructura ósea clara';

  @override
  String get skullScan => 'Escaneo de Cráneo';

  @override
  String get skullScanDesc =>
      'Mira directamente a la cámara para una imagen craneal óptima';

  @override
  String get fullBody => 'Cuerpo Completo';

  @override
  String get fullBodyDesc =>
      'Párate a 2-3 metros de distancia para un escaneo esquelético completo';

  @override
  String get petScan => 'Escaneo de Mascota';

  @override
  String get petScanDesc =>
      'Mantén al sujeto quieto durante el proceso de escaneo';

  @override
  String get proTips => 'Consejos de Escaneo';

  @override
  String get tipGoodLighting =>
      'Usa iluminación adecuada para mejores resultados';

  @override
  String get tipDifferentAngles =>
      'Prueba diferentes ángulos para un análisis completo';

  @override
  String get tipShareFriends => 'Comparte escaneos para comparación';

  @override
  String get tipSaveFavorites => 'Guarda escaneos importantes en el historial';

  @override
  String get startScanningNow => 'Comenzar a Escanear';

  @override
  String get preferences => 'Preferencias';

  @override
  String get soundEffects => 'Efectos de Sonido';

  @override
  String get soundEffectsDesc =>
      'Sonidos de escaneo y retroalimentación háptica';

  @override
  String get language => 'Idioma';

  @override
  String get chooseLanguage => 'Elegir idioma de la aplicación';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get purchases => 'Compras';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get restorePurchasesDesc =>
      'Restaurar compras dentro de la aplicación';

  @override
  String get noPurchases => 'No hay compras para restaurar.';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get termsOfUse => 'Términos de Uso';

  @override
  String get disclaimer => 'Descargo de Responsabilidad';

  @override
  String appVersion(Object version) {
    return 'Escáner de Rayos X v$version';
  }

  @override
  String get entertainmentWarning =>
      'Solo para entretenimiento. No es un rayos X real.';

  @override
  String get supportEmail => 'support@xrayscanner.app';

  @override
  String get cameraPermission => 'Acceso a Cámara Requerido';

  @override
  String get cameraPermissionDesc =>
      'Se requiere acceso a la cámara para la funcionalidad de escaneo.\\nToca abajo para otorgar permiso.';

  @override
  String get openSettings => 'Abrir Configuración';

  @override
  String get goBack => 'Volver';

  @override
  String get readDisclaimer => 'Leer Descargo Completo';

  @override
  String get disclaimerRead => 'Descargo Leído';

  @override
  String get acceptContinue => 'Aceptar y Continuar';

  @override
  String get pleaseReadFirst => 'Por favor lee primero el descargo completo';

  @override
  String get scanningInProgress => 'Escaneo en progreso...';

  @override
  String get calibratingSensors => 'Calibrando sensores...';

  @override
  String get analyzingStructure => 'Analizando estructura ósea...';

  @override
  String get processingImage => 'Procesando datos de imagen...';

  @override
  String get scanComplete => 'Escaneo Completo';

  @override
  String get scanningActive => 'Escaneo Activo';
}
