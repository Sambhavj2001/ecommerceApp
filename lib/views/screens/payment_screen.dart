import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/helper_widgets/loading_indicator.dart';
import 'package:ecommerce_app/views/screens/home_structure.dart';
import 'package:get/get.dart';

import '../../helper_widgets/custom_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: 'Choose Payment Method'
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : customButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();

                    VxToast.show(context, msg: 'Order placed successfully');

                    Get.offAll(Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: 'Place my order',
                ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethods.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        height: 120,
                        colorBlendMode: controller.paymentIndex == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                value: true,
                                onChanged: (value) {},
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: 5,
                        right: 10,
                        child: paymentMethods[index]
                            .text
                            .white
                            .size(16)
                            .fontFamily(semibold)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .rounded
                      .border(
                        width: 4,
                        color: controller.paymentIndex.value == index
                            ? darkFontGrey
                            : Colors.transparent,
                        style: BorderStyle.solid,
                      )
                      .shadowMax
                      .margin(EdgeInsets.all(8))
                      .clip(Clip.antiAlias)
                      .make(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
