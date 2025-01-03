import 'package:event/data/repository/auth_repository_fire.dart';
import 'package:event/domain/models/auth/user_app.dart';
import 'package:event/ui/auth/bloc/auth/auth_bloc.dart';
import 'package:event/ui/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: AuthRepositoryFire(),
      )..add(const InitialAuthEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthBloc, UserApp>(
          builder: (context, state) {
            if (state is UserUnregistered) {
              return Center(
                child: ElevatedButton(
                  onPressed: () => context.read<AuthBloc>().add(
                        const SingInAnonymouslyEvent(),
                      ),
                  child: Text(state is UserRegistered ? 'Out' : 'Login'),
                ),
              );
            }
            return const HomePage();
          },
        ),
      ),
    );
  }
}
