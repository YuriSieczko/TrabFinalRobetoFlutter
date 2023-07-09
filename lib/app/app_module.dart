import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/my_application/my_application.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
  ];
  @override
  List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/myapplication', module: MyApplication()),
  ];
}
