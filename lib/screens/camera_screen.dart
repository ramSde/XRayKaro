import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../core/constants.dart';
import '../services/permission_service.dart';
import '../services/storage_service.dart';
import '../widgets/animated_scan_line.dart';
import '../widgets/skeleton_overlay.dart';
import '../main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _permissionGranted = false;
  bool _isInitialized = false;
  bool _isScanning = false;
  bool _isCapturing = false;
  int _selectedCameraIndex = 0;
  double _scanProgress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final hasPermission = await PermissionService.hasCameraPermission();
      if (!hasPermission) {
        final granted = await PermissionService.requestCameraPermission();
        if (!granted) {
          if (mounted) setState(() => _permissionGranted = false);
          return;
        }
      }

      // PERFORMANCE OPTIMIZATION: Use pre-fetched cameras if available
      _cameras = globalCameras.isNotEmpty ? globalCameras : await availableCameras();
      if (_cameras.isEmpty) {
        _handleCameraError('No cameras found on this device.');
        return;
      }
      await _startCamera(_selectedCameraIndex);
      if (mounted) setState(() => _permissionGranted = true);
    } catch (e) {
      debugPrint('Camera init error: $e');
      _handleCameraError('Failed to initialize camera. Please restart the app.');
    }
  }

  void _handleCameraError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _startCamera(int index) async {
    await _controller?.dispose();
    _controller = CameraController(
      _cameras[index],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _controller!.initialize();
      await _controller!.lockCaptureOrientation();
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint('Camera start error: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    setState(() => _isInitialized = false);
    await _startCamera(_selectedCameraIndex);
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_isCapturing) return;

    setState(() {
      _isCapturing = true;
      _isScanning = true;
      _scanProgress = 0;
    });

    // Simulate scanning animation
    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(const Duration(milliseconds: 40));
      if (mounted) setState(() => _scanProgress = i / 100);
    }

    try {
      final XFile file = await _controller!.takePicture();
      await StorageService.incrementScanCount();

      if (mounted) {
        setState(() {
          _isScanning = false;
          _isCapturing = false;
        });
        Navigator.pushNamed(context, '/result', arguments: file.path);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _isCapturing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to capture photo. Try again!')),
        );
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _startCamera(_selectedCameraIndex);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (!_permissionGranted) {
      return _buildPermissionDenied(context);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Camera Preview ───────────────────────────────────────────────
          if (_isInitialized && _controller != null)
            CameraPreview(_controller!)
          else
            Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.neonBlue),
              ),
            ),

          // ── Glowing frame border ─────────────────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.neonBlue.withValues(alpha: 0.6),
                  width: 2,
                ),
              ),
            ),
          ),

          // Corner decorations
          ..._buildCorners(size),

          // ── Skeleton Overlay ─────────────────────────────────────────────
          if (_isInitialized)
            Positioned.fill(
              child: SkeletonOverlay(
                animate: !_isScanning,
                opacity: 0.55,
              ),
            ),

          // ── Scan Line Animation ──────────────────────────────────────────
          if (_isInitialized && !_isScanning)
            Positioned.fill(
              child: AnimatedScanLine(
                width: size.width,
                height: size.height,
              ),
            ),

          // ── Scanning Overlay ─────────────────────────────────────────────
          if (_isScanning)
            Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SkeletonOverlay(animate: true, opacity: 0.9),
                    const SizedBox(height: 32),
                    const Text(
                      AppStrings.scanningText,
                      style: TextStyle(
                        color: AppColors.neonBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: LinearProgressIndicator(
                        value: _scanProgress,
                        backgroundColor: AppColors.neonBlue.withValues(alpha: 0.15),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.neonBlue),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(_scanProgress * 100).toInt()}%',
                      style: TextStyle(
                          color: AppColors.neonBlue.withValues(alpha: 0.8),
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

          // ── Top bar ──────────────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Semantics(
                      label: 'Go back to home',
                      button: true,
                      child: _CircleButton(
                        icon: Icons.arrow_back_ios_rounded,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.neonBlue.withValues(alpha: 0.4)),
                      ),
                      child: const Text(
                        '🎭 Fun Filter Active',
                        style:
                            TextStyle(color: AppColors.neonBlue, fontSize: 12),
                      ),
                    ),
                    if (_cameras.length > 1)
                      Semantics(
                        label: 'Switch camera',
                        button: true,
                        child: _CircleButton(
                          icon: Icons.flip_camera_ios_rounded,
                          onTap: _switchCamera,
                        ),
                      )
                    else
                      const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
          ),

          // ── Bottom controls ───────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 16),
                child: Column(
                  children: [
                    // Disclaimer text
                    Text(
                      AppStrings.entertainmentDisclaimer,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Capture button
                    Semantics(
                      label: 'Take photo',
                      button: true,
                      enabled: !_isCapturing,
                      child: GestureDetector(
                        onTap: _isCapturing ? null : _capturePhoto,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isCapturing
                                ? Colors.grey
                                : AppColors.neonBlue.withValues(alpha: 0.9),
                            boxShadow: [
                              if (!_isCapturing)
                                BoxShadow(
                                  color: AppColors.neonBlue.withValues(alpha: 0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                            ],
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: Icon(
                            Icons.camera_rounded,
                            color: Colors.white,
                            size: _isCapturing ? 28 : 36,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCorners(Size size) {
    const cLen = 28.0;
    const cThick = 3.0;
    const color = AppColors.neonBlue;
    final positions = [
      {'top': 0.0, 'left': 0.0, 't': true, 'l': true},
      {'top': 0.0, 'right': 0.0, 't': true, 'r': true},
      {'bottom': 0.0, 'left': 0.0, 'b': true, 'l': true},
      {'bottom': 0.0, 'right': 0.0, 'b': true, 'r': true},
    ];

    return positions.map((p) {
      return Positioned(
        top: p['top'] as double?,
        left: p['left'] as double?,
        bottom: p['bottom'] as double?,
        right: p['right'] as double?,
        child: SizedBox(
          width: cLen,
          height: cLen,
          child: CustomPaint(
            painter: _CornerPainter(
              isTop: p.containsKey('t'),
              isLeft: p.containsKey('l'),
              color: color,
              thickness: cThick,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildPermissionDenied(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('📷', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 20),
                const Text(
                  'Camera Access Needed!',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  AppStrings.cameraPermissionDenied,
                  style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.6),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  onPressed: () {
                    PermissionService.openSettings();
                  },
                  icon: const Icon(Icons.settings_outlined),
                  label: const Text('Open App Settings'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonBlue,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Go Back',
                      style: TextStyle(color: AppColors.textSecondary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.5),
          border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.4)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final bool isTop;
  final bool isLeft;
  final Color color;
  final double thickness;

  _CornerPainter({
    required this.isTop,
    required this.isLeft,
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (isTop && isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (isTop && !isLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!isTop && isLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => false;
}
