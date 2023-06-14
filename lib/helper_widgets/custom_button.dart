import 'package:ecommerce_app/consts/consts.dart';

Widget customButton({
  String? title,
  onPress,
  color,
  textColor,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
