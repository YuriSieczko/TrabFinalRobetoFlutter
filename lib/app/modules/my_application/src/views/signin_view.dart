import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../authentication/domain/user_credencial_entity.dart';
import '../authentication/presenter/controller/auth_store.dart';
import '../common/messages/messages_app.dart';
import '../components/form_field_login.dart';

class SignInPage extends StatelessWidget {
  final _userLoginController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AuthStore authStore = Modular.get<AuthStore>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //authStore.userSignOut();
          Modular.to.pop();
        },
        label: const Text('Voltar'),
        // backgroundColor: Colors.black,
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.08,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.lock_person_rounded,
                      size: size.height * 0.2,
                    ),
                    SizedBox(height: size.height * 0.008),
                    const Text(
                      'My App Login',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: size.height * 0.03),
                    FormFieldLogin(
                      hintName: 'E-mail do Usuário',
                      icon: Icons.person_2_outlined,
                      controller: _userLoginController,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: size.height * 0.01),
                    FormFieldLogin(
                      hintName: 'Senha',
                      icon: Icons.lock,
                      controller: _userPasswordController,
                      isObscured: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Modular.to.pushNamed('./signup-page'),
                        child: const Text(
                          'Cadastra-se',
                          style: TextStyle(
                            color: Color.fromARGB(255, 65, 81, 81),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    ScopedListener<AuthStore, UserCredentialApp?>(
                      store: authStore,
                      //onState: (context_, state) => Modular.to.navigate("./home"),
                      onState: (context_, state) => Modular.to.pop(),
                      onError: (context, error) =>
                          MessagesApp.showCustom(context, error.toString()),
                      child: Container(
                        width: size.width * 0.75,
                        height: size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              authStore.userSignIn(
                                  email: _userLoginController.text.trim(),
                                  password:
                                      _userPasswordController.text.trim());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              //shape: const StadiumBorder(),
                              //backgroundColor: Colors.black,
                              ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    const Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                              //color: Color.fromARGB(255, 65, 81, 81),
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Entrar com Google',
                            style: TextStyle(
                                //fontSize: 20,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                              // color: Color.fromARGB(255, 65, 81, 81),
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
