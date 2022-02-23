import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:regex_forms/app/modules/home/controllers/home_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  Color getPasswordDifficultyColor(PasswordDifficulty? difficulty) {
    switch (difficulty) {
      case PasswordDifficulty.easy:
        return Colors.red;
      case PasswordDifficulty.medium:
        return Colors.orange;
      case PasswordDifficulty.hard:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

  String getPasswordDifficultyText(PasswordDifficulty? difficulty) {
    switch (difficulty) {
      case PasswordDifficulty.easy:
        return 'Easy';
      case PasswordDifficulty.medium:
        return 'Normal';
      case PasswordDifficulty.hard:
        return 'Hard';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return ReactiveForm(
        formGroup: controller.formGroupRegister,
        child: Column(
          children: [
            // const SizedBox(height: 10),
            ReactiveTextField(
              formControlName: controller.userFormName,
              validationMessages: (control) => {
                ValidationMessage.required: 'Please enter a user',
              },
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'User',
                labelText: 'User',
              ),
            ),
            // const SizedBox(height: 25),
            ReactiveTextField(
              formControlName: controller.passwordFormName,
              validationMessages: (control) => {
                ValidationMessage.required: 'Please enter a password',
                ValidationMessage.minLength:
                    'Password must be at least 6 characters',
              },
              obscureText: !controller.isShowPassword,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => controller.onTapShowPassword(),
                  icon: controller.isShowPassword
                      ? Icon(Icons.remove_red_eye_outlined)
                      : Icon(Icons.visibility_off_outlined),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                getPasswordDifficultyText(controller.passwordDifficulty),
                style: TextStyle(
                  color:
                      getPasswordDifficultyColor(controller.passwordDifficulty),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ReactiveTextField(
              formControlName: controller.nameFormName,
              validationMessages: (control) => {
                ValidationMessage.required: 'Please enter name',
                ValidationMessage.pattern: 'Only letters allowed',
              },
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
              ),
            ),
            // const SizedBox(height: 25),
            ReactiveTextField(
              formControlName: controller.emailFormName,
              validationMessages: (control) => {
                ValidationMessage.required: 'Please enter email',
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'user@mail.com',
                labelText: 'Email',
              ),
            ),
            // const SizedBox(height: 25),
            ReactiveTextField(
              formControlName: controller.phoneNumberFormName,
              validationMessages: (control) => {
                ValidationMessage.required: 'Please enter a phone number',
                ValidationMessage.minLength:
                    'Your phone number must contain 9 digits',
                ValidationMessage.maxLength:
                    'Your phone number must contain 9 digits',
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+51 999 999 999',
                labelText: 'Phone number',
              ),
            ),
            // const SizedBox(height: 25),
            ReactiveTextField(
              formControlName: controller.birthdayFormName,
              validationMessages: (control) => {
                ValidationMessage.required: 'Please enter a birthday date',
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '20/12/1997',
                labelText: 'Birthday',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
