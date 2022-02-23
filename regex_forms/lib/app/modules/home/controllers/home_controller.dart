import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum PasswordDifficulty {
  easy,
  medium,
  hard,
}

class HomeController extends GetxController {
  late FormGroup formGroupRegister;
  final String userFormName = 'user';
  final String passwordFormName = 'password';
  final String nameFormName = 'name';
  final String lastNameFormName = 'last_name';
  final String phoneNumberFormName = 'phone_number';
  final String emailFormName = 'email';
  final String dniFormName = 'dni';
  final String birthdayFormName = 'birthday';
  final String genderFormName = 'gender';
  final String departmentFormName = 'department';
  final String provinceFormName = 'province';
  final String districtFormName = 'district';

  PasswordDifficulty? get passwordDifficulty => _passwordDifficulty;
  PasswordDifficulty? _passwordDifficulty;

  bool get isShowPassword => _isShowPassword;
  bool _isShowPassword = false;

  static const pClientNamesRegex = r'^[A-Za-záéíóúñÑÁÉÍÓÚ ]*$';
  String pRegexPhone =
      r'^(\+[0-9]{2,4} ?)([0-9]{9}|\d{2,4}-\d{2,4}(-\d{2,4})?)$';
  String pRegexEmail = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  String pRegexUser = r'[a-zA-Z0-9]$';
  String pRegexPasswordEasy = r'[a-z]{6,}$';
  String pRegexPasswordNormal = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)\S{6,}$';
  String pRegexPasswordHard =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])\S{6,}$';
  String pRegexUserInPassword = r'^';
  String pRegexDate =
      r'^(?:(?:31(\/)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';
  int lastLenght = 0;

  final count = 0.obs;
  @override
  void onInit() {
    _initForms();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void getPasswordDifficulty(String? pass) {
    RegExp expEasy = RegExp(pRegexPasswordEasy);
    RegExp expNormal = RegExp(pRegexPasswordNormal);
    RegExp expHard = RegExp(pRegexPasswordHard);
    if (pass == null || pass == '') {
      _passwordDifficulty = null;
    } else if (expHard.hasMatch(pass)) {
      _passwordDifficulty = PasswordDifficulty.hard;
      print('hard');
    } else if (expNormal.hasMatch(pass)) {
      _passwordDifficulty = PasswordDifficulty.medium;
      print('normal');
    } else if (expEasy.hasMatch(pass)) {
      _passwordDifficulty = PasswordDifficulty.easy;
      print('easy');
    }
    update();
  }

  /// TODO: This method is not working
  void completeSlashDate() {
    String? date = formGroupRegister.control(birthdayFormName).value;
    if (date == null || date == '') {
      return;
    }
    // if (date[date.length - 1] == '/') {
    //   return;
    // }
    if (date.length == 2) {
      formGroupRegister.control(birthdayFormName).value = '$date/';
    } else if (date.length == 5) {
      formGroupRegister.control(birthdayFormName).value = '$date/';
    }
  }

  void onTapShowPassword() {
    _isShowPassword = !_isShowPassword;
    update();
  }

  void _initForms() {
    formGroupRegister = FormGroup({
      userFormName: FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(
          pRegexUser,
          validationMessage: 'Only letters and numbers',
        ),
      ]),
      passwordFormName: FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(6),
        Validators.pattern(
          pRegexUserInPassword,
          validationMessage: 'The user must not match in the password',
        ),
      ]),
      nameFormName: FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(pClientNamesRegex),
      ]),
      lastNameFormName: FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(pClientNamesRegex),
      ]),
      phoneNumberFormName: FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(
          pRegexPhone,
          validationMessage: 'Must be contain the country code',
        ),
      ]),
      emailFormName: FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(
          pRegexEmail,
          validationMessage: 'Must be a valid email address',
        ),
      ]),
      birthdayFormName: FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(pRegexDate,
            validationMessage: 'Must be like 12/12/1999'),
      ]),
    });
    formGroupRegister.valueChanges.listen((dynamic value) {
      getPasswordDifficulty(value[passwordFormName]);
      final userInput = value[userFormName] ?? '';
      pRegexUserInPassword = r'^(?!.*' + userInput + ').*';
      formGroupRegister.control(passwordFormName).setValidators([
        Validators.required,
        Validators.minLength(6),
        Validators.pattern(
          pRegexUserInPassword,
          validationMessage: 'The user must not match in the password',
        ),
      ]);

      /// TODO: Here might have been
      // if (value[birthdayFormName] != null) {
      //   lastLenght = value[birthdayFormName].length;
      // } else {
      //   lastLenght = 0;
      // }
      // if (value[birthdayFormName] != null &&
      //     lastLenght != 4 &&
      //     lastLenght != 7) {
      //   final String date = value[birthdayFormName] ?? '';
      //   // completeSlashDate();
      //   print('hello');
      // }
    });
  }
}
