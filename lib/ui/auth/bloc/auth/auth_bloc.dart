import 'package:bloc/bloc.dart';
import 'package:event/domain/models/auth/user_app.dart';
import 'package:event/domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authRepository,
  }) : super(const AuthState.initial()) {
    on<InitialAuthEvent>(_onInit);
    on<SingInAnonymouslyEvent>(_onSingInAnonymously);
  }
  final AuthRepository authRepository;

  Future<void> _onInit(
    InitialAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach(
      authRepository.getAuthUser,
      onData: (d) => state.copyWith(
        userApp: d,
        isLoading: false,
      ),
    );
  }

  Future<void> _onSingInAnonymously(
    SingInAnonymouslyEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    authRepository.signInAnonymously();
  }
}
