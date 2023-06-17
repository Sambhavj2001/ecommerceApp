import 'dart:io';

import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/helper_widgets/background.dart';
import 'package:ecommerce_app/helper_widgets/customTextField.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return backGroundWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              customButton(
                color: redColor,
                textColor: whiteColor,
                title: 'Change',
                onPress: () {
                  controller.changeImage(context);
                },
              ),
              Divider(),
              20.heightBox,
              customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              20.heightBox,
              customTextField(
                controller: controller.oldpasswordController,
                hint: passwordHint,
                title: oldpass,
                isPass: true,
              ),
              20.heightBox,
              customTextField(
                controller: controller.newpasswordController,
                hint: passwordHint,
                title: newpass,
                isPass: true,
              ),
              20.heightBox,
              controller.isLoading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : customButton(
                      color: redColor,
                      textColor: whiteColor,
                      title: 'Save',
                      onPress: () async {
                        controller.isLoading(true);
                        //if images is not selected
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImg();
                        } else {
                          controller.profileImgLink = data['imageUrl'];
                        }

                        //if old password matches
                        if (data['password'] ==
                            controller.oldpasswordController.text) {
                          await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldpasswordController.text,
                            newpassword: controller.newpasswordController.text,
                          );

                          await controller.updateProfile(
                            imgUrl: controller.profileImgLink,
                            name: controller.nameController.text,
                            password: controller.newpasswordController.text,
                          );
                          VxToast.show(context, msg: 'Updated');
                        } else {
                          VxToast.show(context, msg: 'Wrong old Password');
                          controller.isLoading(false);
                        }
                      },
                    ).box.width(double.infinity).make(),
            ],
          )
              .box
              .white
              .rounded
              .shadowSm
              .padding(EdgeInsets.all(16))
              .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    );
  }
}
