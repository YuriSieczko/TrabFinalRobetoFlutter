import 'package:dartz/dartz.dart';

import '../../../common/errors/errors_classes.dart';
import '../user_credencial_entity.dart';

abstract class IAuthSignUpUseCase {
  Future<Either<Failure, UserCredentialApp>> call(
      String email, String password, String name);
}
