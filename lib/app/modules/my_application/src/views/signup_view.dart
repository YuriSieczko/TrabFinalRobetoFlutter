import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../authentication/domain/user_credencial_entity.dart';
import '../authentication/presenter/controller/auth_store.dart';
import '../common/errors/errors_messagens.dart';
import '../common/messages/messages_app.dart';
import '../components/form_field_login.dart';

class SignUpPage extends StatelessWidget {
  final _userLoginController = TextEditingController();
  final _userNameController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userConfirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpPage({super.key});

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
        //backgroundColor: Colors.black,
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
                      'My App Login - Sign Up',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: size.height * 0.04),
                    FormFieldLogin(
                      hintName: 'E-mail do Usuário',
                      icon: Icons.person_2_outlined,
                      controller: _userLoginController,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: size.height * 0.01),
                    FormFieldLogin(
                      hintName: 'Nome do Usuário',
                      icon: Icons.person_2_outlined,
                      controller: _userNameController,
                    ),
                    SizedBox(height: size.height * 0.01),
                    FormFieldLogin(
                      hintName: 'Senha',
                      icon: Icons.lock,
                      controller: _userPasswordController,
                      isObscured: true,
                    ),
                    SizedBox(height: size.height * 0.01),
                    FormFieldLogin(
                      hintName: 'Confirmação de Senha',
                      icon: Icons.lock,
                      controller: _userConfirmPasswordController,
                      isObscured: true,
                    ),
                    SizedBox(height: size.height * 0.04),
                    ScopedListener<AuthStore, UserCredentialApp?>(
                      store: authStore,
                      onError: (context, error) =>
                          MessagesApp.showCustom(context, error.toString()),
                      onState: (context_, state) => Modular.to.pop(),
                      child: Container(
                        width: size.width * 0.75,
                        height: size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_userPasswordController.text.trim() !=
                                  _userConfirmPasswordController.text.trim()) {
                                MessagesApp.showCustom(
                                    context, MessagesError.passwordMismatch);
                                return;
                              }
                              authStore.userSignUp(
                                email: _userLoginController.text.trim(),
                                password: _userPasswordController.text.trim(),
                                name: _userNameController.text.trim(),
                              );
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
