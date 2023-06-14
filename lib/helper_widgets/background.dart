import 'package:ecommerce_app/consts/consts.dart';

Widget backGroundWidget({Widget? child}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
