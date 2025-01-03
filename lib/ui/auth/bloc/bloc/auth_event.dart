part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class InitialAuthEvent extends AuthEvent {
  const InitialAuthEvent();
}
