import 'package:flutter_modular/flutter_modular.dart';

import 'my_application.dart';

class HomeGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    await Modular.isModuleReady<MyApplication>();
    return true;
  }
}
