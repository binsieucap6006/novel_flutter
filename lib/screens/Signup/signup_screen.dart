import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';

import '../../components/background.dart';
import 'components/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Text(
                  "Sign Up".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                const SizedBox(height: defaultPadding),
                const SizedBox(height: defaultPadding),
              ],
            ),
            const Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: SignUpForm(),
                ),
                Spacer(),
              ],
            ),
            // const SocalSignUp()
          ],
        ),
      ),
    );
  }
}
