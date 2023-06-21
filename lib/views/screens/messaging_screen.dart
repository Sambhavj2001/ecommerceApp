import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/views/screens/chat_screen.dart';
import 'package:get/get.dart';

import '../../helper_widgets/loading_indicator.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            'My Messages'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No message\'s yet!'
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .size(20)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          () => ChatScreen(),
                          arguments: [
                            data[index]['friend_name'],
                            data[index]['toId'],
                          ],
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: darkFontGrey,
                        child: Icon(
                          Icons.person,
                          color: whiteColor,
                        ),
                      ),
                      title: '${data[index]['friend_name']}'
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      subtitle: '${data[index]['last_msg']}'.text.make(),
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
