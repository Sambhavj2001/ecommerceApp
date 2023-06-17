import 'package:ecommerce_app/consts/consts.dart';

Widget loadingIndicator() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
