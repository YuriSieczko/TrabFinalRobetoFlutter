import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../authentication/presenter/controller/auth_store.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthStore authStore = context.watch<AuthStore>();
    //authStore.userSignOut();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (authStore.isAuth) {
                    print('Logout');
                    authStore.userSignOut();
                  } else {
                    print('Login');
                    authStore.userSignIn(
                        email: 'bb@com.br', password: '123456');
                    print(authStore.state!.name);
                  }
                },
                child: Text('bota')),
            ScopedBuilder(
              store: authStore,
              onLoading: (context) {
                return ElevatedButton(
                  onPressed: () {},
                  child: botao(authStore.isAuth),
                );
              },
              onState: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (authStore.isAuth) {
                      print('Logout');
                      authStore.userSignOut();
                    } else {
                      print('Login');
                      authStore.userSignIn(
                          email: 'bb@com.br', password: '123456');
                      print(authStore.state!.name);
                    }
                  },
                  child: Text('Teste'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget botao(bool mark) {
    if (mark) {
      print('entrou no teste');
      return const Text('Teste');
    } else {
      print('entrou no indicator');
      return const CircularProgressIndicator(
        color: Colors.black,
      );
    }
  }
}
