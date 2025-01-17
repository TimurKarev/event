part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class InitialAuthEvent extends AuthEvent {
  const InitialAuthEvent();
}

class SingInAnonymouslyAuthEvent extends AuthEvent {
  const SingInAnonymouslyAuthEvent();
}

class SignOutAuthEvent extends AuthEvent {
  const SignOutAuthEvent();
}
