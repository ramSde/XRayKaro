import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Semantics(
                    button: true,
                    label: 'Open navigation menu',
                    child: IconButton(
                      icon: const Icon(Icons.menu_rounded,
                          color: AppColors.neonBlue),
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
                      icon: const Icon(Icons.settings_outlined,
                          color: AppColors.neonBlue),
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
                                                .withValues(alpha: 0.25),
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
                      child: GestureDetector(
                        onTap: _startScan,
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: AppColors.neonGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.neonBlue.withValues(alpha: 0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_rounded,
                                    color: Colors.white, size: 28),
                                SizedBox(width: 12),
                                Text(
                                  'START X-RAY SCAN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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

                    // ── Info Card ──────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.neonBlue.withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xAAFF3D71).withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.info_outline_rounded,
                                color: AppColors.danger, size: 24),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Prank Disclaimer',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'This app is for fun only and doesn\'t scan real bones.',
                                  style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12),
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
                          color: AppColors.cardBg.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.neonBlue.withValues(alpha: 0.15)),
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

        ],
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
