class UserCredentialApp {
  final AuthType authType;
  final String? uId;
  final String? name;
  late final String email;
  final String? password;
  final String? token;
  final DateTime? tokenExpireIn;

  UserCredentialApp({
    required this.authType,
    this.uId,
    this.name,
    required this.email,
    this.password,
    this.token,
    this.tokenExpireIn,
  });
}

enum AuthType { email, google }
