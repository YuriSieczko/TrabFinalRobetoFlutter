import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/user_credencial_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/modules/my_application/src/authentication/data/use_cases/auth_signin_user_case_impl.dart';
import 'app/modules/my_application/src/authentication/domain/user_credencial_entity.dart';
import 'app/modules/my_application/src/authentication/external/cache/auth_local_cache_sp_impl.dart';
import 'app/modules/my_application/src/authentication/manager/auth_service_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // var service = AuthServiceManager(AuthType.email);
  // var useCase = AuthSignInUserCaseImpl(service());
  // var resp = await useCase('aa@com.br', '123456');
  // await FirebaseAuth.instance.signOut();
  // var t = await FirebaseAuth.instance.currentUser!.getIdTokenResult();
  // print(t.authTime);
  // print(t.expirationTime);
  // print(DateTime.now());
  // resp.fold((l) {
  //   print('entrou no erro');
  //   print(l);
  // }, (r) async {
  //   print(r.tokenExpireIn);
  // });

  // FirebaseFirestore.instance.collection('teste').add({'teste': 'ola mundo'});
  //print('oi');
  // var service = AuthServiceManager(AuthType.email);
  // var useCase = AuthSignInUserCaseImpl(service());
  // var resp = await useCase('aa@com.br', '123456');
  // resp.fold((l) {
  //   print('entrou no erro');
  //   print(l);
  // }, (r) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   var localCache = AuthLocalCacheSharedPrefsImpl(sp);
  //   var resp1 = await localCache.delete(r.uId!);
  //   resp1.fold((l) => print(l), (r) => print(r));
  //   var resp2 = await localCache.fetch(r.uId!);
  //   resp2.fold((l) => print(l), (r) => print(r));
  //   var resp3 = await localCache.save(user: r);
  //   resp3.fold((l) => print(l), (r) => print(r));
  //   var resp4 = await localCache.fetch(r.uId!);
  //   resp4.fold((l) => print(l), (r) => print(r));
  //   var resp5 = await localCache.delete(r.uId!);
  //   resp5.fold((l) => print(l), (r) => print(r));
  //   var resp6 = await localCache.fetch(r.uId!);
  //   resp6.fold((l) => print(l), (r) => print(r));
  //   var conv = UserCredecialMapper.entityToMap(r);
  //   var conv4 = UserCredecialMapper.entityToJson(r);
  //   var conv1 = UserCredecialMapper.mapToJson(conv);
  //   var conv2 = UserCredecialMapper.jsonToMap(conv1);
  //   var conv3 = UserCredecialMapper.mapToEntity(conv2);
  //   print(conv);
  // });

  // // var resp = await useCase('aa', '123456', 'maria');
  // resp.fold((l) {
  //   print('entrou aqui');
  //   print(l);
  //   print(l);
  // }, (r) {
  //   print(r.email);
  // });
  // // var teste = FirebaseAuth.instance.currentUser!;
  // print('Teste de currente user');
  // print(teste.email);
  // var teste2 = await teste.getIdTokenResult();
  // print(teste2.authTime);
  // await FirebaseAuth.instance.signOut();

  // var service = AuthServiceManager(AuthType.email);
  // var useCase = AuthSignUpUserCaseImpl(service());
  // var resp = await useCase('cc@com.br', '123456', 'joao');

  // var user = await FirebaseAuth.instance
  //     .signInWithEmailAndPassword(email: 'aa@com.br', password: '123456');
  // var ref = FirebaseFirestore.instance.collection('Users');
  // var t = await ref.doc(user.user?.uid).get();

  // var users = await FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(user.user?.uid)
  //     .get();

  //print(t.data());

  /* parte testada 

  var service = AuthServiceManager(AuthType.email);
  var useCase = AuthSignInUserCaseImpl(service());
  var resp = await useCase('aa@com.br', '123456');

  resp.fold((l) {
    print('entrou aqui');
    print(l);
    print(l);
  }, (r) {
    print(r.email);
  });

   fim da parte testada*/

  //FirebaseFirestore.instance.collection('teste').add({'teste': 'ola mundo'});

  // try {
  //   await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: 'aa@com.br', password: '123452');
  // } on FirebaseAuthException catch (e) {
  //   if (e.message!.contains('wrong-password')) {
  //     throw UserWrongPassword('classe errada');
  //   }
  // } catch (e) {
  //   print(e);
  // }
  return runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
