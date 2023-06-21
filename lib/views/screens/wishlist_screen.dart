import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../helper_widgets/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            'My Wishlist'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No product\'s yet!'
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .size(20)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      "${data[index]['p_imgs'][0]}",
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    title: '${data[index]['p_name']}'
                        .text
                        .fontFamily(semibold)
                        .size(16)
                        .make(),
                    subtitle: '${data[index]['p_price']}'
                        .numCurrency
                        .text
                        .fontFamily(semibold)
                        .color(redColor)
                        .make(),
                    trailing: IconButton(
                      onPressed: () async {
                        await firestore
                            .collection(productsCollection)
                            .doc(data[index].id)
                            .set({
                          'p_wishlist':
                              FieldValue.arrayRemove([currentUser!.uid])
                        }, SetOptions(merge: true));
                      },
                      icon: Icon(Icons.favorite_outlined),
                      color: redColor,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
