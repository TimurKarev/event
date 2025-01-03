import 'package:event/domain/models/auth/user_app.dart';
import 'package:event/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryFire implements AuthRepository {
  @override
  Stream<UserApp> get getAuthUser =>
      FirebaseAuth.instance.userChanges().map((u) {
        if (u != null) {
          return UserAuthenticated(uid: u.uid);
        }
        return const UserUnregistered();
      });

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
