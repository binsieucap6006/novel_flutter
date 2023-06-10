import 'package:flutter/material.dart';

class SubMenuWidget extends StatelessWidget {
  const SubMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            for (int i = 0; i <= 5; i++)
              //Single Submenu item.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Image.asset(
                    "assets/images/Capture1.PNG",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            //End of Single Submenu item
          ],
        ),
      ),
    );
  }
}
