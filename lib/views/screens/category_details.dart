import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/helper_widgets/background.dart';
import 'package:ecommerce_app/views/screens/item_details.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return backGroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => "Baby Clothing"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .make(),
                  ),
                ),
              ),

              //items container
              20.heightBox,
              Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imgP5,
                          height: 150,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        'Laptop 4GB/64GB'
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        '\$600'
                            .text
                            .size(16)
                            .fontFamily(bold)
                            .color(redColor)
                            .make(),
                        10.heightBox,
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(EdgeInsets.all(12))
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .make()
                        .onTap(() {
                      Get.to(() => IteamDetails(title: 'Boday'));
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
