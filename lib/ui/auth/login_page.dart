import 'package:event/ui/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ElevatedButton(
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('LoginPage'),
              onPressed: () => context.read<AuthBloc>().add(
                    const SingInAnonymouslyAuthEvent(),
                  ),
            );
          },
        ),
      ),
    );
  }
}
