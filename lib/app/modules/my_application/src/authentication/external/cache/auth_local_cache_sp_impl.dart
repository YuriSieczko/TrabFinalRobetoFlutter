import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/errors/errors_classes.dart';
import '../../../common/errors/errors_messagens.dart';
import '../../domain/user_credencial_entity.dart';
import '../../domain/user_credencial_mapper.dart';
import '../../presenter/cache_interfaces/auth_local_cache_contract.dart';

class AuthLocalCacheSharedPrefsImpl implements IAuthLocalCache {
  late SharedPreferences _sp;

  final String _key = 'USER_DATA';

  AuthLocalCacheSharedPrefsImpl(SharedPreferences sp) {
    _sp = sp;
  }

  @override
  Future<Either<Failure, bool>> delete(
      {required UserCredentialApp user}) async {
    try {
      await _sp.remove(_key);
      return const Right(true);
    } catch (e) {
      return Left(
        UserSharedPrefencesError(MessagesError.deleteSharedP),
      );
    }

    //return Left(DefaultError(MessagesError.defaultError));
  }

  @override
  Future<Either<Failure, UserCredentialApp>> fetch() async {
    try {
      final result = _sp.getString(_key);

      if (result == null || result.isEmpty) {
        return Left(
          UserSharedPrefencesError(MessagesError.saveSharedPKeyNotFound),
        );
      }

      return Right(UserCredecialMapper.jsonToEnsity(result));
    } catch (e) {
      return Left(
        UserSharedPrefencesError(MessagesError.fetchSharedP),
      );
    }

    //return Left(DefaultError(MessagesError.defaultError));
  }

  @override
  Future<Either<Failure, bool>> save({required UserCredentialApp user}) async {
    try {
      var value = UserCredecialMapper.entityToJson(user);
      await _sp.setString(_key, value);
      return const Right(true);
    } catch (e) {
      return Left(
        UserSharedPrefencesError(MessagesError.saveSharedP),
      );
    }

    //return Left(DefaultError(MessagesError.defaultError));
  }
}
