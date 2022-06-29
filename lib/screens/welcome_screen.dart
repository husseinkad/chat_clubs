import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/my_button.dart';
import 'registration_screen.dart';
import 'signin_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Image.asset('images/logo.png'),
                ),
                const Text(
                  'ChatClubs',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 150),
            MyButton(
              color: Colors.grey[100]!,
              title: 'Sign in',
              onPressed: () {
                Get.to(const SignInScreen());
              },
            ),
            MyButton(
              color: Colors.grey[100]!,
              title: 'Register',
              onPressed: () {
                Get.to(const RegistrationScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
