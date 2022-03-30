import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rive/rive.dart';
import 'package:rive_example/authentication/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;

  @override
  void initState() {
    super.initState();
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        loadingController.reset();
      } else if (status == AnimationStatus.dismissed) {
        loadingController.forward();
      }
    });
  }

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 108, 147, 168),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 300,
                  child: GestureDetector(
                    onTap: state.teddyController.resetLoop,
                    onLongPressStart: (_) =>
                        state.teddyController.onLongPressStart(),
                    onLongPressEnd: (_) =>
                        state.teddyController.onLongPressEnd(),
                    child: RiveAnimation.asset(
                      'assets/teddy.riv',
                      controllers: state.teddyController.listControllers,
                      stateMachines: const ['State Machine 1'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 182, 211, 226),
                  child: ReactiveForm(
                    formGroup: state.loginForm,
                    child: Column(
                      children: [
                        ReactiveTextField(
                          formControlName: LoginState.emailController,
                          validationMessages: (control) => {
                            ValidationMessage.required:
                                'Debe ingresar un usuario',
                            ValidationMessage.email: 'Debe ingresar un email',
                          },
                          onTap: state.teddyController.email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ),
                            label: const Text('User'),
                          ),
                          onEditingComplete: state.teddyController.pass,
                        ),
                        ReactiveTextField(
                          formControlName: LoginState.passwordController,
                          validationMessages: (control) => {
                            ValidationMessage.required:
                                'Debe ingresar una contraseña',
                          },
                          onTap: state.teddyController.pass,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            ),
                            label: const Text('Password'),
                          ),
                          onEditingComplete: state.teddyController.email,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      state.teddyController.error();
                    },
                    child: const Text('Login'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
