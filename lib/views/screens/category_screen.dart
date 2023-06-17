import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/views/screens/category_details.dart';
import 'package:get/get.dart';

import '../../helper_widgets/background.dart';

class CatergoryScreen extends StatelessWidget {
  const CatergoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PRoductController());
    return backGroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: 200,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoryImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoryList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowMd
                  .make()
                  .onTap(() {
                controller.getSubCategoies(categoryList[index]);
                Get.to(
                  () => CategoryDetails(title: categoryList[index]),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
