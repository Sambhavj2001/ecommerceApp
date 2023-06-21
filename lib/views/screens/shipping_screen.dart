import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/helper_widgets/customTextField.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:ecommerce_app/views/screens/payment_screen.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Shipping Info'
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: customButton(
          onPress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => PaymentMethods());
            } else {
              VxToast.show(context, msg: 'Please fill the form');
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: 'Continue',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
              hint: 'Address',
              title: 'Address',
              isPass: false,
              controller: controller.addressController,
            ),
            customTextField(
              hint: 'City',
              title: 'City',
              isPass: false,
              controller: controller.cityController,
            ),
            customTextField(
              hint: 'State',
              title: 'State',
              isPass: false,
              controller: controller.stateController,
            ),
            customTextField(
              hint: 'Country',
              title: 'Country',
              isPass: false,
              controller: controller.countryController,
            ),
            customTextField(
              hint: 'Postal Code',
              title: 'Postal Code',
              isPass: false,
              controller: controller.postalCodeController,
            ),
            customTextField(
              hint: 'Phone No.',
              title: 'Phone Number',
              isPass: false,
              controller: controller.phoneNoController,
            ),
          ],
        ),
      ),
    );
  }
}
