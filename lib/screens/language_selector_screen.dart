import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../services/storage_service.dart';

class LanguageSelectorScreen extends StatefulWidget {
  const LanguageSelectorScreen({super.key});

  @override
  State<LanguageSelectorScreen> createState() => _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen> {
  String _selectedLocale = 'en';

  @override
  void initState() {
    super.initState();
    _selectedLocale = StorageService.locale;
  }

  void _selectLanguage(String code) async {
    await StorageService.setLocale(code);
    setState(() => _selectedLocale = code);
    if (mounted) {
      // Small delay to let the user see the selection before closing
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) Navigator.pop(context, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: AppColors.cardBg,
        foregroundColor: AppColors.neonBlue,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          itemCount: AppStrings.languages.length,
          separatorBuilder: (context, index) => const Divider(
            color: Color(0x2200D4FF),
            height: 1,
            indent: 12,
            endIndent: 12,
          ),
          itemBuilder: (context, index) {
            final lang = AppStrings.languages[index];
            final code = lang['code']!;
            final isSelected = _selectedLocale == code;

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Text(
                _getFlagForLocale(code),
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                lang['name']!,
                style: TextStyle(
                  color: isSelected ? AppColors.neonBlue : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle_rounded, color: AppColors.neonBlue, size: 24)
                  : null,
              onTap: () => _selectLanguage(code),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            );
          },
        ),
      ),
    );
  }

  String _getFlagForLocale(String code) {
    switch (code) {
      case 'en': return '🇺🇸';
      case 'es': return '🇪🇸';
      case 'fr': return '🇫🇷';
      case 'de': return '🇩🇪';
      case 'hi': return '🇮🇳';
      case 'ar': return '🇸🇦';
      case 'pt': return '🇵🇹';
      case 'ru': return '🇷🇺';
      case 'zh': return '🇨🇳';
      case 'ja': return '🇯🇵';
      case 'ko': return '🇰🇷';
      case 'tr': return '🇹🇷';
      case 'it': return '🇮🇹';
      case 'id': return '🇮🇩';
      default: return '🌐';
    }
  }
}
