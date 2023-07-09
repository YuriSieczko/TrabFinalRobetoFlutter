import 'dart:convert';

import 'user_credencial_entity.dart';

abstract class UserCredecialMapper {
  static Map<String, dynamic> entityToMap(UserCredentialApp user) {
    return {
      'uId': user.uId,
      'email': user.email,
      'name': user.name,
      'password': user.password,
      'token': user.token,
      'tokenExpireIn': user.tokenExpireIn!.toIso8601String(),
      'authType': user.authType.name,
    };
  }

  static String entityToJson(UserCredentialApp user) {
    var map = entityToMap(user);
    return mapToJson(map);
  }

  static UserCredentialApp mapToEntity(Map<String, dynamic> map) {
    return UserCredentialApp(
      uId: map['uId'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
      token: map['token'],
      tokenExpireIn: DateTime.parse(map['tokenExpireIn']),
      authType: map['authType'] == 'email' ? AuthType.email : AuthType.google,
    );
  }

  static String mapToJson(Map<String, dynamic> map) => json.encode(map);
  static Map<String, dynamic> jsonToMap(String jSon) => json.decode(jSon);
  static UserCredentialApp jsonToEnsity(String jSon) {
    var map = jsonToMap(jSon);
    return mapToEntity(map);
  }
}
