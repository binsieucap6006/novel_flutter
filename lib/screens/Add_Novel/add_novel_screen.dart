import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/responsive.dart';
import 'package:novel_flutter/screens/Add_Novel/components/add_novel_form.dart';
import '../../components/background.dart';
import '../Home/components/navbar_widget.dart';

class AddNovelScreen extends StatelessWidget {
  const AddNovelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileAddNovelScreen(),
        ),
      ),
    );
  }
}

class MobileAddNovelScreen extends StatelessWidget {
  const MobileAddNovelScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Text(
              "Create your Novel".toUpperCase(),
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            const SizedBox(height: defaultPadding),
            const SizedBox(height: defaultPadding),
          ],
        ),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: AddNovelForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
