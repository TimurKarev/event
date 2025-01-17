import 'package:event/domain/models/auth/user_app.dart';

abstract class AuthRepository {
  Stream<UserApp> get getAuthUser;

  Future<void> signOut();

  Future<void> signInAnonymously();
}
