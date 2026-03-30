
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../language/languag_provider.dart';
import '../theme/colors.dart';
import '../utils/sizes.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.paddingHorizontalS.horizontal,
            vertical: AppSpacing.paddingVerticalXS.vertical,
          ),
          value: ref.watch(languageProvider).languageCode,
          isDense: true,
          items: [
            DropdownMenuItem(value: 'en', child: Text('English')),
            DropdownMenuItem(value: 'bn', child: Text('বাংলা')),
          ],
          onChanged: (String? newLang) {
            if (newLang != null) {
              ref.read(languageProvider.notifier).changeLocale(newLang);
            }
          },
        ),
      ),
    );
  }
}

class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider).languageCode;

    // Determine the label to show (showing what is currently active)
    final String label = currentLanguage == 'en' ? 'English' : 'বাংলা';

    return GestureDetector(
      onTap: () {
        // Toggle logic: if en -> bn, if bn -> en
        final nextLang = currentLanguage == 'en' ? 'bn' : 'en';
        ref.read(languageProvider.notifier).changeLocale(nextLang);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE3BF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black, // White text looks best on amber
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}