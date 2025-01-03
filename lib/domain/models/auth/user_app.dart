import 'package:equatable/equatable.dart';

sealed class UserApp extends Equatable {
  const UserApp();

  @override
  List<Object?> get props => [];
}

class UserUnregistered extends UserApp {
  const UserUnregistered();
}

sealed class UserRegistered extends UserApp {
  const UserRegistered({
    required this.uid,
  });

  final String uid;

  @override
  List<Object?> get props => [uid];
}

class UserAnonymous extends UserRegistered {
  const UserAnonymous({
    required super.uid,
  });
}

class UserAuthenticated extends UserRegistered {
  const UserAuthenticated({
    required super.uid,
  });
}
