import 'package:dartz/dartz.dart';

import '../../../common/errors/errors_classes.dart';
import '../user_credencial_entity.dart';

abstract class IAuthService {
  Future<Either<Failure, UserCredentialApp>> signIn(
      String email, String password);
  Future<void> signOut();
  Future<Either<Failure, UserCredentialApp>> signUp(
    String email,
    String password,
    String name,
  );
}
