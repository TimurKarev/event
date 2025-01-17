import 'package:event/data/repository/auth_repository_fire.dart';
import 'package:event/internal/router/router_config.dart';
import 'package:event/ui/auth/bloc/auth/auth_bloc.dart';
import 'package:event/ui/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepositoryFire(),
          )..add(const InitialAuthEvent()),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
            ),
            useMaterial3: true,
          ),
          routerConfig: routerConfig(context.read<AuthBloc>()),
        );
      }),
    );
  }
}
