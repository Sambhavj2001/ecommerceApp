import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controllers/home_controllers.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var paymentIndex = 0.obs;
  var placingOrder = false.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneNoController = TextEditingController();

  late dynamic productSnapShot;
  var products = [];

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  getProductsDetails() {
    products.clear();

    for (var i = 0; i < productSnapShot.length; i++) {
      products.add({
        'color': productSnapShot[i]['color'],
        'img': productSnapShot[i]['img'],
        'vendor_id': productSnapShot[i]['vendor_id'],
        'tprice': productSnapShot[i]['tprice'],
        'qty': productSnapShot[i]['qty'],
        'title': productSnapShot[i]['title'],
      });
    }
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);

    await getProductsDetails();

    await firestore.collection(ordersCollection).doc().set({
      'order_code': '123456789',
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_country': countryController.text,
      'order_by_phone': phoneNoController.text,
      'order_by_postalcode': postalCodeController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_on_delivery': false,
      'order_delivered': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });

    placingOrder(false);
  }

  clearCart() {
    for (var i = 0; i < productSnapShot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapShot[i].id).delete();
    }
  }
}
