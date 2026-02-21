import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants.dart';

class SamplesScreen extends StatelessWidget {
  const SamplesScreen({super.key});

  static const List<Map<String, String>> _samples = [
    {
      'title': 'Hand Scan',
      'emoji': '🖐️',
      'description': 'See the bones in your hand with our fun filter!',
    },
    {
      'title': 'Skull Scan',
      'emoji': '💀',
      'description': 'Turn any face into a spooky skeleton!',
    },
    {
      'title': 'Full Body',
      'emoji': '🦴',
      'description': 'Complete skeleton effect for full body photos',
    },
    {
      'title': 'Pet Scan',
      'emoji': '🐕',
      'description': 'Even your pets can get the X-ray treatment!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Sample Ideas'),
        backgroundColor: AppColors.cardBg,
        foregroundColor: AppColors.neonBlue,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.neonBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.neonBlue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      color: AppColors.neonBlue, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Try these fun ideas for your next X-ray scan!',
                      style: TextStyle(
                        color: AppColors.neonBlue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ..._samples.map((sample) => _SampleCard(
                  title: sample['title']!,
                  emoji: sample['emoji']!,
                  description: sample['description']!,
                )),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Text(
                    '💡 Pro Tips',
                    style: TextStyle(
                      color: AppColors.neonBlue,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _TipItem('Use good lighting for best results'),
                  _TipItem('Try different angles and poses'),
                  _TipItem('Share with friends for laughs!'),
                  _TipItem('Save your favorites to gallery'),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/camera'),
              icon: const Icon(Icons.camera_alt_rounded),
              label: const Text('Start Scanning Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonBlue,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  final String title;
  final String emoji;
  final String description;

  const _SampleCard({
    required this.title,
    required this.emoji,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              color: AppColors.neonBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: 32.sp)),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;
  const _TipItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle,
              color: AppColors.success, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
