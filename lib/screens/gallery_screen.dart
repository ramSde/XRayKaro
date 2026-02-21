import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import '../core/constants.dart';
import '../services/ad_service.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<FileSystemEntity> _images = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
    AdService.loadBannerAd();
  }

  Future<void> _loadImages() async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        setState(() => _isLoading = false);
        return;
      }

      final picturesDir = Directory(
          '${directory.parent.parent.parent.parent.path}/Pictures/XrayFunCamera');

      if (!await picturesDir.exists()) {
        setState(() => _isLoading = false);
        return;
      }

      final files = picturesDir
          .listSync()
          .where((f) => f.path.endsWith('.jpg') || f.path.endsWith('.png'))
          .toList();

      files.sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

      setState(() {
        _images = files;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading gallery: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteImage(String path) async {
    try {
      await File(path).delete();
      await _loadImages();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Image deleted'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Failed to delete image'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('My X-ray Gallery'),
        backgroundColor: AppColors.cardBg,
        foregroundColor: AppColors.neonBlue,
        actions: [
          if (_images.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                setState(() => _isLoading = true);
                _loadImages();
              },
            ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.neonBlue),
              )
            : _images.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: EdgeInsets.all(12.r),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.r,
                      mainAxisSpacing: 12.r,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final file = File(_images[index].path);
                      return _GalleryItem(
                        file: file,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/result',
                          arguments: file.path,
                        ),
                        onDelete: () => _showDeleteDialog(file.path),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('📷', style: TextStyle(fontSize: 64.sp)),
            SizedBox(height: 16.h),
            Text(
              'No X-ray Images Yet',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Take your first fun skeleton scan to see it here!',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/camera'),
              icon: const Icon(Icons.camera_alt_rounded),
              label: const Text('Start Scanning'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonBlue,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(String path) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        title: const Text('Delete Image?',
            style: TextStyle(color: AppColors.textPrimary)),
        content: const Text(
          'This action cannot be undone.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteImage(path);
            },
            child: const Text('Delete',
                style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }
}

class _GalleryItem extends StatelessWidget {
  final File file;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _GalleryItem({
    required this.file,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.neonBlue.withOpacity(0.3)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                file,
                fit: BoxFit.cover,
                cacheWidth: 400,
              ),
              Positioned(
                top: 4.r,
                right: 4.r,
                child: IconButton(
                  icon: Icon(Icons.delete_rounded,
                      color: AppColors.danger, size: 20.sp),
                  onPressed: onDelete,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
