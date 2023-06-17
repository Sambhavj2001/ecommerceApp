import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:get/get.dart';

class IteamDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const IteamDetails({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PRoductController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title!.text.make(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      height: 350,
                      viewportFraction: 1.0,
                      itemCount: data['p_imgs'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data["p_imgs"][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    10.heightBox,
                    title!.text
                        .size(18)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      size: 25,
                      stepInt: true,
                    ),
                    10.heightBox,
                    '${data['p_price']}'
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Seller'.text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              '${data['p_seller']}'
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(16)
                                  .make(),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        )
                      ],
                    )
                        .box
                        .height(60)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),

                    20.heightBox,
                    //color section
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    'Color: '.text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(data['p_colors'][index])
                                              .withOpacity(1.0))
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .make()
                                          .onTap(() {
                                        controller.changeColorIndex(index);
                                      }),
                                      Visibility(
                                        visible: index ==
                                            controller.colorIndex.value,
                                        child: Icon(Icons.done,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //quantity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: 'Quantity: '
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity();
                                        controller.calculatedPrice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                    controller.quantity.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(
                                          int.parse(data['p_quantity']),
                                        );
                                        controller.calculatedPrice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                    '(${data['p_quantity']} avaliable)'
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    'Total: '.text.color(textfieldGrey).make(),
                              ),
                              '${controller.totalPrice.value}'
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,
                    'Description'
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    '${data['p_desc']}'.text.color(darkFontGrey).make(),

                    //buttons section
                    20.heightBox,
                    ListView(
                      shrinkWrap: true,
                      children: List.generate(
                        itemDetailButtonList.length,
                        (index) => ListTile(
                          title: itemDetailButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),

                    //products you also like section
                    20.heightBox,
                    productyoualsolike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),

                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                imgP1,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
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
                            ],
                          )
                              .box
                              .white
                              .rounded
                              .padding(EdgeInsets.all(8))
                              .margin(EdgeInsets.symmetric(horizontal: 4))
                              .make(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: customButton(
                color: redColor,
                onPress: () {},
                textColor: whiteColor,
                title: 'Add To Cart'),
          ),
        ],
      ),
    );
  }
}
