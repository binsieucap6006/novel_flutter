import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/screens/Add_Novel/components/add_novel_form.dart';
import '../../components/background.dart';

class AddNovelScreen extends StatelessWidget {
  const AddNovelScreen({
    super.key,
  });
  //String novelId;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Text(
            "Create your Novel".toUpperCase(),
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          const SizedBox(height: defaultPadding),
          const SizedBox(height: defaultPadding),
          const SizedBox(
            height: 50,
          ),
          const Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: AddNovelForm(),
              ),
              Spacer(),
            ],
          ),
        ],

        // const SocalSignUp()
      ),
    );
  }
}

// class MobileAddNovelScreen extends StatelessWidget {
//   const MobileAddNovelScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           "Create your Novel".toUpperCase(),
//           style: const TextStyle(
//               fontSize: 30, fontWeight: FontWeight.bold, color: kPrimaryColor),
//         ),
//         const SizedBox(height: defaultPadding),
//         const SizedBox(height: defaultPadding),
//         const Row(
//           children: [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: AddNovelForm(),
//             ),
//             Spacer(),
//           ],
//         ),
//       ],

//       // const SocalSignUp()
//     );
//   }
// }
