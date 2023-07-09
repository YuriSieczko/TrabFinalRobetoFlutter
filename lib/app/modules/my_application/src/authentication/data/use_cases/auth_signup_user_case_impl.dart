import 'package:dartz/dartz.dart';

import '../../../common/errors/errors_classes.dart';
import '../../domain/services_interfaces/auth_service_contract.dart';
import '../../domain/use_cases_interfaces/auth_signup_user_case_contract.dart';
import '../../domain/user_credencial_entity.dart';

class AuthSignUpUserCaseImpl implements IAuthSignUpUseCase {
  final IAuthService _authService;

  AuthSignUpUserCaseImpl(this._authService);

  @override
  Future<Either<Failure, UserCredentialApp>> call(
      String email, String password, String name) async {
    var result = await _authService.signUp(email, password, name);

    return result;
  }
}
