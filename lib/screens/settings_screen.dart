import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants.dart';
import '../services/storage_service.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundEnabled = true;
  String _themeMode = 'system';
  String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() {
      _soundEnabled = StorageService.soundEnabled;
      _themeMode = StorageService.themeMode;
      _appVersion = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.cardBg,
        foregroundColor: AppColors.neonBlue,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: ListView(
          padding: EdgeInsets.all(20.r),
          children: [
            // ── Preferences ────────────────────────────────────────────────
            const _SectionHeader('Preferences'),
            const SizedBox(height: 12),
            _SettingsCard(children: [
              Semantics(
                label: 'Toggle sound effects and haptic feedback',
                child: _SwitchTile(
                  icon: Icons.volume_up_rounded,
                  label: 'Sound Effects',
                  subtitle: 'Scan sounds & haptic feedback',
                  value: _soundEnabled,
                  onChanged: (v) async {
                    await StorageService.setSoundEnabled(v);
                    setState(() => _soundEnabled = v);
                  },
                ),
              ),
              const _Divider(),
              Semantics(
                button: true,
                label: 'Choose app language',
                child: _NavTile(
                  icon: Icons.translate_rounded,
                  label: 'Language',
                  onTap: () async {
                    final nav = Navigator.of(context);
                    final changed = await nav.pushNamed('/language');
                    if (changed == true && context.mounted) {
                      final newLocale = Locale(StorageService.locale, '');
                      XrayFunApp.setLocale(context, newLocale);
                    }
                  },
                ),
              ),
            ]),

            const SizedBox(height: 20),

            // ── Theme ──────────────────────────────────────────────────────
            const _SectionHeader('Theme'),
            const SizedBox(height: 12),
            _SettingsCard(children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'system',
                      label: Text('System'),
                      icon: Icon(Icons.brightness_auto_rounded),
                    ),
                    ButtonSegment(
                      value: 'dark',
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode_rounded),
                    ),
                    ButtonSegment(
                      value: 'light',
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode_rounded),
                    ),
                  ],
                  selected: {_themeMode},
                  onSelectionChanged: (Set<String> newSelection) {
                    _setTheme(newSelection.first);
                  },
                  showSelectedIcon: false,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.neonBlue.withOpacity(0.2);
                        }
                        return null;
                      },
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.neonBlue;
                        }
                        return AppColors.textSecondary;
                      },
                    ),
                    side: WidgetStateProperty.all(
                      BorderSide(color: AppColors.neonBlue.withValues(alpha: 0.2)),
                    ),
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 20),

            // ── Purchases ──────────────────────────────────────────────────
            const _SectionHeader('Purchases'),
            const SizedBox(height: 12),
            _SettingsCard(children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16),
                leading: const Icon(Icons.restore_rounded,
                    color: AppColors.neonBlue, size: 22),
                title: const Text('Restore Purchases',
                    style: TextStyle(
                        color: AppColors.textPrimary, fontSize: 15)),
                subtitle: const Text('Restore in-app purchases',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,
                    color: AppColors.textSecondary, size: 14),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No purchases to restore.'),
                      backgroundColor: AppColors.cardBg,
                    ),
                  );
                },
              ),
            ]),

            const SizedBox(height: 20),

            // ── Legal ──────────────────────────────────────────────────────
            const _SectionHeader('Legal'),
            const SizedBox(height: 12),
            _SettingsCard(children: [
              Semantics(
                button: true,
                label: 'Read Privacy Policy',
                child: _NavTile(
                  icon: Icons.lock_outline,
                  label: 'Privacy Policy',
                  onTap: () => Navigator.pushNamed(context, '/privacy'),
                ),
              ),
              const _Divider(),
              Semantics(
                button: true,
                label: 'Read Terms of Use',
                child: _NavTile(
                  icon: Icons.description_outlined,
                  label: 'Terms of Use',
                  onTap: () => Navigator.pushNamed(context, '/terms'),
                ),
              ),
              const _Divider(),
              Semantics(
                button: true,
                label: 'Read App Disclaimer',
                child: _NavTile(
                  icon: Icons.info_outline_rounded,
                  label: 'Disclaimer',
                  onTap: () => Navigator.pushNamed(context, '/disclaimer'),
                ),
              ),
            ]),

            const SizedBox(height: 32),

            // ── App info ───────────────────────────────────────────────────
            Center(
              child: Column(
                children: [
                  const Text('💀', style: TextStyle(fontSize: 28)),
                  const SizedBox(height: 6),
                  Text(
                    'Xray Fun Camera v$_appVersion',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '⚠️ For entertainment only. Not real X-ray.',
                    style: TextStyle(
                        color: AppColors.danger,
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'support@xrayfuncamera.app',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _setTheme(String value) async {
    await StorageService.setThemeMode(value);
    setState(() => _themeMode = value);
    
    if (mounted) {
      final mode = switch (value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
      XrayFunApp.setThemeMode(context, mode);
    }
  }
}

// ── Private widgets ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: AppColors.neonBlue.withOpacity(0.8),
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
            color: AppColors.neonBlue.withOpacity(0.15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Column(children: children),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      const Divider(color: Color(0x2200D4FF), height: 1);
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      secondary: Icon(icon, color: AppColors.neonBlue, size: 22),
      title: Text(label,
          style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 15)),
      subtitle: Text(subtitle,
          style: const TextStyle(
              color: AppColors.textSecondary, fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.neonBlue,
    );
  }
}


class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavTile(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: AppColors.neonBlue, size: 22),
      title: Text(label,
          style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 15)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          color: AppColors.textSecondary, size: 14),
      onTap: onTap,
    );
  }
}
