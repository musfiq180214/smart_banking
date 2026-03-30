import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>(
      (ref) => LanguageNotifier(),
);

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('bn'));

  void changeLocale(String languageCode) {
    state = Locale(languageCode);
  }
}