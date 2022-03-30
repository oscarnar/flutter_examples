import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rive_example/authentication/controllers/teddy_controller.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void onInit() {
    state.loginForm.valueChanges.listen((dynamic value) {});
  }

  void onLogin() {}
}
