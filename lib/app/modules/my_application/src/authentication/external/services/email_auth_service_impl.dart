import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/errors/errors_classes.dart';
import '../../../common/errors/errors_messagens.dart';
import '../../domain/services_interfaces/auth_service_contract.dart';
import '../../domain/user_credencial_entity.dart';

class EmailAuthServiceImpl implements IAuthService {
  @override
  Future<Either<Failure, UserCredentialApp>> signIn(
      String email, String password) async {
    try {
      var response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var responeCredential = await response.user?.getIdTokenResult();
      var dataResponde = await FirebaseFirestore.instance
          .collection('Users')
          .doc(response.user?.uid)
          .get();

      UserCredentialApp userReponse = UserCredentialApp(
        authType: AuthType.email,
        email: response.user!.email as String,
        uId: response.user?.uid,
        token: responeCredential?.token,
        tokenExpireIn: responeCredential?.expirationTime,
        password: password,
        name: dataResponde.data()?['nome'] as String,
      );

      return Right(userReponse);
    } on FirebaseAuthException catch (error) {
      if (error.code.contains('wrong-password')) {
        return Left(UserWrongPassword(MessagesError.userWrongPassword));
      } else if (error.code.contains('user-not-found')) {
        return Left(UserNotFound(MessagesError.userNotFound));
      } else if (error.code.contains('invalid-email')) {
        return Left(UserInvalidEmail(MessagesError.userInvalidEmail));
      } else if (error.code.contains('user-disabled')) {
        return Left(UserDisabled(MessagesError.userDisabled));
      }
    } catch (e) {
      return Left(DefaultError(MessagesError.defaultError));
    }

    return Left(DefaultError(MessagesError.defaultError));
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<Either<Failure, UserCredentialApp>> signUp(
      String email, String password, String name) async {
    try {
      var response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var responeCredential = await response.user?.getIdTokenResult();

      FirebaseFirestore.instance
          .collection('Users')
          .doc(response.user?.uid)
          .set({
        'nome': name,
        'email': response.user!.email as String,
      });

      UserCredentialApp userReponse = UserCredentialApp(
        authType: AuthType.email,
        email: response.user!.email as String,
        uId: response.user?.uid,
        token: responeCredential?.token,
        tokenExpireIn: responeCredential?.expirationTime,
        name: name,
        password: password,
      );

      return Right(userReponse);
    } on FirebaseAuthException catch (error) {
      if (error.code.contains('email-already-in-use')) {
        return Left(EmailAlreadyInUse(MessagesError.emailAlreadyInUse));
      } else if (error.code.contains('invalid-email')) {
        return Left(InvalidEmail(MessagesError.invalidEmail));
      } else if (error.code.contains('operation-not-allowed')) {
        return Left(
            EmailOperationNotAllowed(MessagesError.operationNotAllowed));
      } else if (error.code.contains('weak-password')) {
        return Left(EmailWeakPassword(MessagesError.weakPassword));
      }
    } catch (e) {
      return Left(DefaultError(MessagesError.defaultError));
    }

    return Left(DefaultError(MessagesError.defaultError));
  }
}
