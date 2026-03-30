import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/language/languag_provider.dart';
import 'core/navigation/app_navigator.dart';
import 'core/service/hive_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/utils/enums.dart';
import 'flavor_config.dart';
import 'generated/l10n.dart';

Future<void> smart_banking() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(HiveService.settingsBox);
  await Hive.openBox(HiveService.cartBox);
  await Hive.openBox(HiveService.ordersBox);
  await Hive.openBox(HiveService.locationBox);

  FlavorConfig.instantiate(
    flavor: Flavor.staging,
    baseUrl: "",
    appTitle: "Tasks (Staging)",
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('bn')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: ProviderScope(child: const MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ Update user type at the earliest point
    // updateUserTypeOnStart(ref);

    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(languageProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: FlavorConfig.instance.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, widget) {
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw StateError('widget is null');
      },
    );
  }
}
/*
 valid user:
 to generate translation: change intl_bn.arb and intl_en.arb and run: dart run intl_utils:generate
  to generate app icon and replace default app icon:
  update directory of app icon in pubspec.yaml
  In Terminal:
  flutter pub run flutter_launcher_icons:main
  To RUN Staging:
  flutter run --flavor staging -t lib/main_staging.dart
  To Build Staging APK:
  flutter build apk --debug -t lib/main_staging.dart
  To Build Production APK (which can be shared):
  flutter build apk --flavor production -t lib/main_production.dart
  Installable Debug APK to share is: app-staging-debug.apk
*/