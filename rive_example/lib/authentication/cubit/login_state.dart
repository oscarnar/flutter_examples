part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState({
    required this.loginForm,
    required this.teddyController,
  });

  static const String emailController = 'email';
  static const String passwordController = 'password';
  final FormGroup loginForm;

  final TeddyController teddyController;

  @override
  List<Object> get props => [loginForm];
}

class LoginInitial extends LoginState {
  LoginInitial()
      : super(
          teddyController: TeddyController(),
          loginForm: FormGroup(
            {
              LoginState.emailController: FormControl<String>(
                validators: [
                  Validators.required,
                  Validators.email,
                ],
              ),
              LoginState.passwordController: FormControl<String>(
                validators: [
                  Validators.required,
                  Validators.minLength(6),
                ],
              ),
            },
          ),
        );
}
