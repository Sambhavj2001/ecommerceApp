import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/controllers/profile_controller.dart';
import 'package:ecommerce_app/helper_widgets/profile_button.dart';
import 'package:ecommerce_app/views/screens/edit_screen.dart';
import 'package:ecommerce_app/views/screens/login_screen.dart';
import 'package:get/get.dart';

import '../../helper_widgets/background.dart';
import '../../services/firebase_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return backGroundWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        controller.nameController.text = data['name'];
                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imageUrl'],
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                '${data['name']}'
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                '${data['email']}'.text.white.make(),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: whiteColor),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signOutMethod(context);
                              Get.offAll(() => LoginScreen());
                            },
                            child:
                                logout.text.fontFamily(semibold).white.make(),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        profileButton(
                          width: (context.screenWidth / 3.4),
                          count: data['cart_count'],
                          title: 'In The Cart',
                        ),
                        profileButton(
                          width: (context.screenWidth / 3.4),
                          count: data['wishlist_count'],
                          title: 'In The WishList',
                        ),
                        profileButton(
                          width: (context.screenWidth / 3.4),
                          count: data['order_count'],
                          title: 'Your orders',
                        ),
                      ],
                    ),

                    //buttons sections
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(color: darkFontGrey);
                      },
                      itemCount: profileButtonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(
                            profileButtonIcons[index],
                            width: 22,
                          ),
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .shadowSm
                        .margin(EdgeInsets.all(16))
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
