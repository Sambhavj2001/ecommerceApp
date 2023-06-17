import 'package:ecommerce_app/consts/consts.dart';

Widget profileButton({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  ).box.white.rounded.size(width, 80).padding(EdgeInsets.all(4)).make();
}
