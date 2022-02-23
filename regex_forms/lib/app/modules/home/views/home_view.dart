import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:regex_forms/app/modules/home/components/register_form.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegEx'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text(
              'Register form using RegEx',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 12,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: RegisterForm(),
                  ),
                ],
              ),
            ),
            Container(
              height: 54,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
