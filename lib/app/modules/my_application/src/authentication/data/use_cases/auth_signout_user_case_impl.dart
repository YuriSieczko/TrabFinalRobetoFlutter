import '../../domain/services_interfaces/auth_service_contract.dart';
import '../../domain/use_cases_interfaces/auth_signout_user_case_contract.dart';

class AuthSignOutUserCaseImpl implements IAuthSignOutUseCase {
  final IAuthService _authService;

  AuthSignOutUserCaseImpl(this._authService);

  @override
  Future<void> call() async => await _authService.signOut();
}
