import 'package:dartz/dartz.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/user_credencial_entity.dart';

import '../../../common/errors/errors_classes.dart';

abstract class IAuthLocalCache {
  Future<Either<Failure, UserCredentialApp>> fetch();
  Future<Either<Failure, bool>> delete({required UserCredentialApp user});
  Future<Either<Failure, bool>> save({required UserCredentialApp user});
}
