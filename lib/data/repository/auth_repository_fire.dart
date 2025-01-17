import 'package:event/domain/models/auth/user_app.dart';
import 'package:event/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryFire implements AuthRepository {
  @override
  Stream<UserApp> get getAuthUser =>
      FirebaseAuth.instance.authStateChanges().asyncMap((u) {
        if (u != null) {
          return u.isAnonymous
              ? UserAnonymous(uid: u.uid)
              : UserAuthenticated(uid: u.uid);
        }
        return const UserUnregistered();
      });

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signInAnonymously() async =>
      FirebaseAuth.instance.signInAnonymously();
}
