import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/views/screens/orders/order_details.dart';
import 'package:get/get.dart';

import '../../../helper_widgets/loading_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'My Orders'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No order\'s yet!'
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .size(20)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: '${index + 1}'
                        .text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .xl
                        .make(),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .make(),
                    trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: darkFontGrey,
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
