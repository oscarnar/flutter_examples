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

  /// Animation parameters
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMINumber? _numLook;

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
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: GestureDetector(
                          onTap: () => _trigSuccess!
                              .change(true), // state.teddyController.resetLoop,
                          onLongPressStart: (_) =>
                              state.teddyController.onLongPressStart(),
                          onLongPressEnd: (_) =>
                              state.teddyController.onLongPressEnd(),
                          onLongPress: state.teddyController.onLongPressStart,
                          child: RiveAnimation.asset(
                            'assets/teddy_without_v7.riv',
                            controllers: state.teddyController.listControllers,
                            stateMachines: const ['Login Machine'],
                            fit: BoxFit.cover,
                            onInit: (artboard) {
                              final controller =
                                  StateMachineController.fromArtboard(
                                artboard,
                                'Login Machine',
                              );
                              artboard.addController(controller!);
                              _isChecking = controller
                                  .findInput<bool>('isChecking') as SMIBool;
                              _isHandsUp = controller
                                  .findInput<bool>('isHandsUp') as SMIBool;
                              _trigSuccess = controller
                                  .findInput<bool>('trigSuccess') as SMITrigger;
                              _trigFail = controller.findInput<bool>('trigFail')
                                  as SMITrigger;
                              _numLook = controller.findInput<double>('numLook')
                                  as SMINumber;
                              _numLook!.change(0);
                            },
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: const Color.fromARGB(112, 182, 211, 226),
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: ReactiveForm(
                            formGroup: state.loginForm,
                            child: Column(
                              children: [
                                ReactiveTextField(
                                  formControlName: LoginState.emailController,
                                  validationMessages: (control) {
                                    // TODO(oscarnar): Change the validation here
                                    // like onChange() in TextField
                                    if (control.value != null) {
                                      _numLook!.value =
                                          control.value!.toString().length * 3;
                                    }
                                    return {
                                      ValidationMessage.required:
                                          'Debe ingresar un usuario',
                                      ValidationMessage.email:
                                          'Debe ingresar un email',
                                    };
                                  },
                                  onTap: () {
                                    _isHandsUp!.change(false);
                                    _isChecking!.change(
                                      true,
                                    ); //state.teddyController.email,
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    label: const Text('User'),
                                    border: InputBorder.none,
                                  ),
                                  // onEditingComplete: state.teddyController.pass,
                                ),
                                ReactiveTextField(
                                  formControlName:
                                      LoginState.passwordController,
                                  validationMessages: (control) => {
                                    ValidationMessage.required:
                                        'Debe ingresar una contraseña',
                                    ValidationMessage.minLength:
                                        'Debe ingresar minimo 6 caracteres',
                                  },
                                  onTap: () {
                                    _isChecking!.change(false);
                                    _isHandsUp!.change(
                                        true); //state.teddyController.pass,
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    label: const Text('Password'),
                                    border: InputBorder.none,
                                  ),
                                  // onEditingComplete:
                                  //     state.teddyController.email,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 48,
                        width: 180,
                        child: ElevatedButton(
                          onPressed: () async {
                            state.loginForm.markAllAsTouched();
                            if (!state.loginForm.valid) {
                              if (_isHandsUp!.value) {
                                _isHandsUp!.change(false);
                                await Future<void>.delayed(
                                  const Duration(milliseconds: 200),
                                );
                                _trigFail!.change(true);
                                await Future<void>.delayed(
                                  const Duration(milliseconds: 400),
                                );
                                _isHandsUp!.change(true);
                              }
                              _trigFail!.change(true);
                              return;
                            } else {
                              _isChecking!.change(false);
                              _isHandsUp!.change(false);
                              await Future<void>.delayed(
                                const Duration(seconds: 2),
                              );
                              _trigSuccess!.change(true);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login correcto!'),
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
