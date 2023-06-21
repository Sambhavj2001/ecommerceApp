import 'package:ecommerce_app/consts/consts.dart';

Widget orderPlacedDetails({title1, title2, detail1, detail2}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '$title1'.text.fontFamily(semibold).make(),
            5.heightBox,
            '$detail1'.text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '$title2'.text.fontFamily(semibold).make(),
            5.heightBox,
            '$detail2'.text.make(),
          ],
        ).box.width(120).make(),
      ],
    ),
  );
}
