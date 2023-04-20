import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const Text(
          'LOGIN',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
        const SizedBox(height: defaultPadding * 2),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
