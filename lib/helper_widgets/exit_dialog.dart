import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Confirm'.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        'Are you sure you want to exit?'
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
              color: Colors.green,
              onPress: () {
                // SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: 'Yes',
            ),
            customButton(
              color: redColor,
              onPress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: 'No',
            ),
          ],
        ),
      ],
    ).box.roundedSM.color(lightGrey).padding(EdgeInsets.all(16)).make(),
  );
}
