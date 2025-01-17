part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.userApp,
    required this.isLoading,
  });

  const AuthState.initial()
      : this(
          userApp: const UserUnregistered(),
          isLoading: false,
        );

  final UserApp userApp;
  final bool isLoading;

  AuthState copyWith({
    UserApp? userApp,
    bool? isLoading,
  }) =>
      AuthState(
        userApp: userApp ?? this.userApp,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [userApp, isLoading];
}
