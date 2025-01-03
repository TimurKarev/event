import 'package:bloc/bloc.dart';
import 'package:event/domain/models/auth/user_app.dart';
import 'package:event/domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, UserApp> {
  AuthBloc({
    required this.authRepository,
  }) : super(const UserUnregistered()) {
    on<InitialAuthEvent>(_onInit);
  }

  final AuthRepository authRepository;

  Future<void> _onInit(
    InitialAuthEvent event,
    Emitter<UserApp> emit,
  ) async {
    await emit.forEach(
      authRepository.getAuthUser,
      onData: (d) => d,
    );
  }
}
