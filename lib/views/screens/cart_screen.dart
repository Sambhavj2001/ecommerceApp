import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:ecommerce_app/helper_widgets/loading_indicator.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/views/screens/shipping_screen.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'Shopping Cart'
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: 'Cart is empty!'.text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapShot = data;

            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['img']}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title:
                                '${data[index]['title']} (x${data[index]['qty']})'
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: '${data[index]['tprice']}'
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                            trailing: IconButton(
                              onPressed: () {
                                FirestoreServices.deleteDocument(
                                    data[index].id);
                              },
                              icon: Icon(Icons.delete),
                              color: redColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Total price:'
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => '${controller.totalP.value}'
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(lightGolden)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  SizedBox(
                    width: double.infinity,
                    child: customButton(
                      color: redColor,
                      onPress: () {
                        Get.to(() => ShippingDetails());
                      },
                      textColor: whiteColor,
                      title: 'Proceed to shipping',
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
