import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChapterInput extends StatelessWidget {
  const ChapterInput({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final TextEditingController _textcontroller = TextEditingController();

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 400, // do it in both Container
        color: kPrimaryLightColor,
        padding: EdgeInsets.all(5),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // minWidth: _contextWidth(),
            // maxWidth: _contextWidth(),
            maxHeight: height, //when it reach the max it will use scroll
            maxWidth: width,
          ),
          child: TextField(
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: null, //grow automatically
            //focusNode: mrFocus,
            controller: _textcontroller,
            //onSubmitted: currentIsComposing ? _handleSubmitted : null,
            decoration: new InputDecoration.collapsed(
                hintText: 'Please enter a lot of text',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
      ),
    ]);
  }
}
