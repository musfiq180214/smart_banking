import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_banking/core/navigation/route_names.dart';
import 'package:smart_banking/features/add_money/presentation/add_money_screen.dart';
import 'package:smart_banking/features/cash_out/presentation/cash_out_screen.dart';
import 'package:smart_banking/features/landing/presentation/landing_screen.dart';
import 'package:smart_banking/features/sign_up/presentation/otp_confirmation.dart';

import '../../features/login/presentation/login_screen.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/sign_up/presentation/signup_screen.dart';

abstract class AppNavigator {
  AppNavigator._();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver();

  static void goTo(String route, {Object? extra}) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    GoRouter.of(ctx).go(route, extra: extra);
  }

  static void pushTo(String route, {Object? extra}) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    GoRouter.of(ctx).push(route, extra: extra);
  }

  static void pop([Object? result]) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    if (GoRouter.of(ctx).canPop()) {
      GoRouter.of(ctx).pop(result);
    } else {
      GoRouter.of(ctx).go(RouteNames.splash);
    }
  }
}

class AppRoute {
  final String path;
  final Widget Function(BuildContext, GoRouterState) builder;

  const AppRoute({required this.path, required this.builder});
}

final List<AppRoute> appRoutes = [
  AppRoute(path: RouteNames.splash, builder: (_, __) => const SplashPage()),
  AppRoute(path: RouteNames.login, builder: (_, __) => const LoginScreen()),
  AppRoute(path: RouteNames.sign_up, builder: (_, __) => const SignUpScreen()),
  AppRoute(
    path: RouteNames.opt_confirmation,
    builder: (_, state) {
      // Extract the phone number passed via 'extra'
      final phone = state.extra as String? ?? "";
      return OTPConfirmationScreen(phoneNumber: phone);
    },
  ),
  AppRoute(path: RouteNames.landing, builder: (_, __) => const LandingScreen()),
  AppRoute(path: RouteNames.cash_out, builder: (_, __) => const CashOutScreen()),
  AppRoute(path: RouteNames.add_money, builder: (_, __) => const AddMoneyScreen())
];

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: AppNavigator.navigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      for (final r in appRoutes)
        GoRoute(path: r.path, name: r.path, builder: r.builder),
    ],
  );
});