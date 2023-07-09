import '../domain/services_interfaces/auth_service_contract.dart';
import '../domain/user_credencial_entity.dart';
import '../external/services/email_auth_service_impl.dart';

class AuthServiceManager {
  final AuthType _authType;
  AuthServiceManager(this._authType);

  IAuthService call() {
    var service;
    switch (_authType) {
      case AuthType.google:
        service = EmailAuthServiceImpl();
        break;
      case AuthType.email:
        service = EmailAuthServiceImpl();
        break;
    }
    return service;
  }
}
