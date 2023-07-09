import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/Listin/home_screen.dart';

import 'src/authentication/data/use_cases/auth_signin_user_case_impl.dart';
import 'src/authentication/data/use_cases/auth_signout_user_case_impl.dart';
import 'src/authentication/data/use_cases/auth_signup_user_case_impl.dart';
import 'src/authentication/domain/user_credencial_entity.dart';
import 'src/authentication/external/cache/auth_local_cache_sp_impl.dart';
import 'src/authentication/external/services/email_auth_service_impl.dart';
import 'src/authentication/manager/auth_service_manager.dart';
import 'src/authentication/presenter/controller/auth_store.dart';
import 'src/views/home_page.dart';
import 'src/views/page_1.dart';
import 'src/views/page_2.dart';
import 'src/views/signin_view.dart';
import 'src/views/signup_view.dart';

class MyApplication extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => AuthServiceManager(AuthType.email)),
    Bind.lazySingleton((i) => EmailAuthServiceImpl()),
    Bind.singleton((i) => AuthLocalCacheSharedPrefsImpl(i())),
    //   Bind.lazySingleton((i) => AuthLocalCacheSharedPrefsImpl()),
    Bind.lazySingleton((i) => AuthSignInUserCaseImpl(i())),
    Bind.lazySingleton((i) => AuthSignOutUserCaseImpl(i())),
    Bind.lazySingleton((i) => AuthSignUpUserCaseImpl(i())),
    Bind.singleton<AuthStore>(
      (i) => AuthStore(
        userSignIn: i(),
        userSignOut: i(),
        userSignUp: i(),
        localCache: i(),
      ),
      onDispose: (store) => store.destroy,
      selector: (store) => store.state,
    ),
  ];

  // @override
  // List<ModularRoute> routes = [
  //   ChildRoute('/', child: (ctx, args) => SignInPage()),
  //   ChildRoute(
  //     '/home',
  //     child: (context, args) => Home(),
  //   ),
  //   ChildRoute(
  //     '/signup-page',
  //     child: (context, args) => SignUpPage(),
  //   ),
  //   ChildRoute(
  //     '/page1',
  //     child: (context, args) => HomeScreen(),
  //   ),
  //   ChildRoute(
  //     '/page2',
  //     child: (context, args) => Page2(),
  //   ),
  // ];
  @override
  List<ModularRoute> routes = [
    ChildRoute('/', child: (ctx, args) => const Home()),
    ChildRoute(
      '/signin-page',
      child: (context, args) => SignInPage(),
    ),
    ChildRoute(
      '/signup-page',
      child: (context, args) => SignUpPage(),
    ),
    ChildRoute(
      '/page1',
      child: (context, args) => HomeScreen(),
    ),
    ChildRoute(
      '/page2',
      child: (context, args) => Page2(),
    ),
  ];
}
