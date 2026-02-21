import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants.dart';
import '../services/ad_service.dart';
import '../widgets/skeleton_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late Animation<double> _pulseAnim;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatAnim = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _startScan() {
    Navigator.pushNamed(context, '/camera');
  }

  void _shareApp() {
    Share.share('Check out this cool Xray Fun Camera app! 💀\nDownload it now: ${AppStrings.playStoreUrl}');
  }

  void _rateApp() async {
    final url = Uri.parse(AppStrings.playStoreUrl);
    if (await _canLaunch(url)) {
      await launchUrl(url);
    }
  }

  Future<bool> _canLaunch(Uri url) async {
    return await canLaunchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      drawer: _buildDrawer(context),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Custom AppBar ──────────────────────────────────────────────
            Builder(
              builder: (ctx) => SliverAppBar(
                expandedHeight: 120,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(
                  margin: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Semantics(
                    button: true,
                    label: 'Open navigation menu',
                    child: IconButton(
                      icon: Icon(Icons.menu_rounded,
                          color: AppColors.neonBlue, size: 24.sp),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                ),
                title: ShaderMask(
                  shaderCallback: (r) =>
                      AppColors.neonGradient.createShader(r),
                  child: const Text(
                    'Xray Fun Camera',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                centerTitle: true,
                actions: [
                  Semantics(
                    button: true,
                    label: 'Open settings',
                    child: IconButton(
                      icon: Icon(Icons.settings_outlined,
                          color: AppColors.neonBlue, size: 24.sp),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settings'),
                    ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    24, size.height * 0.02, 24, 24),
                child: Column(
                  children: [
                    // ── Hero Icon ────────────────────────────────────
                    AnimatedBuilder(
                      animation:
                          Listenable.merge([_pulseAnim, _floatAnim]),
                      builder: (ctx, _) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnim.value),
                          child: Transform.scale(
                            scale: _pulseAnim.value,
                            child: SizedBox(
                              width: size.width * 0.55,
                              height: size.width * 0.55,
                              child: Stack(
                                children: [
                                  // Glow circle
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.neonBlue
                                                .withOpacity(0.25),
                                            blurRadius: 50,
                                            spreadRadius: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Skeleton painted overlay
                                  const SkeletonOverlay(
                                    animate: true,
                                    opacity: 0.85,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // ── Main CTA ──────────────────────────────────────
                    Semantics(
                      button: true,
                      label: 'Start X-ray scan camera',
                      child: InkWell(
                        onTap: _startScan,
                        borderRadius: BorderRadius.circular(20.r),
                        child: Ink(
                          height: 70.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: AppColors.neonGradient,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.neonBlue.withOpacity(0.4),
                                blurRadius: 20.r,
                                offset: Offset(0, 8.h),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_rounded,
                                    color: Colors.white, size: 28.sp),
                                SizedBox(width: 12.w),
                                Text(
                                  'START X-RAY SCAN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ── Secondary Actions ─────────────────────────────
                    Row(
                      children: [
                        _FeatureTile(
                          icon: '📁', 
                          label: AppStrings.actionGallery,
                          onTap: () => Navigator.pushNamed(context, '/gallery'),
                        ),
                        SizedBox(width: 16.w),
                        _FeatureTile(
                          icon: '🖼️', 
                          label: AppStrings.actionSamples,
                          onTap: () => Navigator.pushNamed(context, '/samples'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ── Info Card ──────────────────────────────────────
                    Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                            color: AppColors.neonBlue.withOpacity(0.15)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: Color(0xAAFF3D71).withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.info_outline_rounded,
                                color: AppColors.danger, size: 24.sp),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Prank Disclaimer',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'This app is for fun only and doesn\'t scan real bones.',
                                  style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Ad Placeholder ──────────────────────────────────
                    if (AdService.bannerAd != null)
                      SizedBox(
                        width: AdService.bannerAd!.size.width.toDouble(),
                        height: AdService.bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: AdService.bannerAd!),
                      )
                    else
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.cardBg.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.neonBlue.withOpacity(0.15)),
                        ),
                        child: const Center(
                          child: Text(
                            'ADVERTISEMENT',
                            style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                                letterSpacing: 2),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // ── Rate & Share ─────────────────────────────────────
                    Semantics(
                      button: true,
                      label: 'Rate app on Play Store',
                      child: _OutlineButton(
                          icon: '🌟',
                          label: 'Support Us - Rate 5 Stars',
                          onTap: _rateApp),
                    ),
                    const SizedBox(height: 12),
                    Semantics(
                      button: true,
                      label: 'Share app with friends',
                      child: _OutlineButton(
                          icon: '🔗', label: 'Share With Friends', onTap: _shareApp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.bgDark2,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: AppColors.mainGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('💀', style: TextStyle(fontSize: 36)),
                SizedBox(height: 8),
                Text(
                  'Xray Fun Camera',
                  style: TextStyle(
                      color: AppColors.neonBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text('Skeleton Prank Simulator',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          _DrawerItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () => Navigator.pop(context)),
          _DrawerItem(
              icon: Icons.camera_alt_outlined,
              label: 'Start Scan',
              onTap: () {
                Navigator.pop(context);
                _startScan();
              }),
          _DrawerItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              }),
          const Divider(color: Color(0x2200D4FF)),
          _DrawerItem(
              icon: Icons.lock_outline,
              label: 'Privacy Policy',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/privacy');
              }),
          _DrawerItem(
              icon: Icons.description_outlined,
              label: 'Terms of Use',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/terms');
              }),
          _DrawerItem(
              icon: Icons.share_outlined,
              label: 'Share App',
              onTap: () {
                Navigator.pop(context);
                _shareApp();
              }),
          _DrawerItem(
              icon: Icons.star_outline_rounded,
              label: 'Rate App',
              onTap: () {
                Navigator.pop(context);
                _rateApp();
              }),
        ],
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _OutlineButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Ink(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.neonPurple.withOpacity(0.6)),
          color: AppColors.neonPurple.withOpacity(0.08),
        ),
        child: Center(
          child: Text(
            '$icon $label',
            style: TextStyle(
              color: const Color(0xFFC4AAFF),
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  const _FeatureTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.neonBlue.withOpacity(0.15)),
          ),
          child: Column(
            children: [
              Text(icon, style: TextStyle(fontSize: 24.sp)),
              SizedBox(height: 8.h),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.neonBlue, size: 22),
      title: Text(
        label,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      ),
      onTap: onTap,
      dense: true,
    );
  }
}
