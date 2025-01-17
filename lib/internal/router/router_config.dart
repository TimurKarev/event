import 'dart:async';

import 'package:event/domain/models/auth/user_app.dart';
import 'package:event/internal/router/path_constants.dart';
import 'package:event/ui/auth/bloc/auth/auth_bloc.dart';
import 'package:event/ui/auth/login_page.dart';
import 'package:event/ui/home/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfig(AuthBloc authBloc) => GoRouter(
      initialLocation: PathConstants.splashScreen.path,
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: _redirect,
      routes: [
        GoRoute(
          path: PathConstants.splashScreen.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: PathConstants.loginScreen.path,
          builder: (context, state) => const LoginPage(),
        ),
      ],
    );

FutureOr<String?> _redirect(BuildContext context, GoRouterState state) async {
  final user = context.read<AuthBloc>().state.userApp;

  if (state.fullPath == PathConstants.loginScreen.path &&
      user is UserUnregistered) {
    return null;
  } else if (state.fullPath == PathConstants.loginScreen.path &&
      user is UserRegistered) {
    return PathConstants.splashScreen.path;
  }

  if (user is UserRegistered) {
    return null;
  }

  return PathConstants.loginScreen.path;
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
