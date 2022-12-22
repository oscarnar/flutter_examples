import 'package:contact_info/domain/blocs/cubit/contacts_cubit.dart';
import 'package:contact_info/domain/entities/address.dart';
import 'package:contact_info/domain/entities/company.dart';
import 'package:contact_info/domain/entities/coordinates.dart';
import 'package:contact_info/domain/entities/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  // ignore: avoid_field_initializers_in_const_classes
  final FormGroup formGroup = FormGroup({
    'name': FormControl<String>(
      validators: [Validators.required],
    ),
    'phone': FormControl<String>(
      validators: [Validators.required, Validators.number],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Name',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                ),
              ),
              ReactiveTextField<String>(
                formControlName: 'name',
                validationMessages: (control) => {
                  ValidationMessage.required: 'The name must not be empty',
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: const Color(0xffF9F9F9),
                  hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Phone',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                ),
              ),
              ReactiveTextField<String>(
                formControlName: 'phone',
                validationMessages: (control) => {
                  ValidationMessage.required: 'The phone must not be empty',
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter your phone',
                  filled: true,
                  fillColor: const Color(0xffF9F9F9),
                  hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formGroup.markAllAsTouched();
          if (formGroup.valid) {
            final name = formGroup.control('name').value.toString();
            final phone = formGroup.control('phone').value.toString();

            final newContact = Person(
              id: 0,
              name: name,
              username: name,
              phone: phone,
              email: name,
              website: name,
              address: Address(
                street: name,
                city: name,
                suite: name,
                zipcode: name,
                coordinates:
                    Coordinates(latitude: -16.3985618, longitude: -71.5374468),
              ),
              company: Company(bs: name, catchPhrase: name, name: name),
            );
            context
                .read<ContactsCubit>()
                .addContact(newContact)
                .then((value) => GoRouter.of(context).pop());
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
