import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
        const SizedBox(height: defaultPadding),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
