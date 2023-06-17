import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/helper_widgets/applogo.dart';
import 'package:ecommerce_app/helper_widgets/background.dart';
import 'package:ecommerce_app/helper_widgets/customTextField.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:ecommerce_app/views/screens/home_structure.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return backGroundWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              'Join our $appname'
                  .text
                  .white
                  .fontFamily(semibold)
                  .size(18)
                  .make(),
              25.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false,
                    ),
                    20.heightBox,
                    customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false,
                    ),
                    20.heightBox,
                    customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true,
                    ),
                    20.heightBox,
                    customTextField(
                      title: retypePass,
                      hint: passwordHint,
                      controller: retypePasswordController,
                      isPass: true,
                    ),
                    20.heightBox,
                    Row(
                      children: [
                        Checkbox(
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    fontFamily: semibold,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: termAndCond,
                                  style: TextStyle(
                                    fontFamily: semibold,
                                    color: redColor,
                                  ),
                                ),
                                TextSpan(
                                  text: ' & ',
                                  style: TextStyle(
                                    fontFamily: semibold,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: semibold,
                                    color: redColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    10.heightBox,
                    controller.isLoading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : customButton(
                            title: sigup,
                            color: isCheck == true ? redColor : lightGrey,
                            textColor: whiteColor,
                            onPress: () async {
                              if (isCheck != false) {
                                controller.isLoading(true);
                                try {
                                  await controller
                                      .signUpMethod(
                                    context: context,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  )
                                      .then((value) {
                                    return controller.storedUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                    );
                                  }).then((value) {
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(() => Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isLoading(false);
                                }
                              }
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Already have an account? '.text.color(fontGrey).make(),
                        login.text.color(redColor).make().onTap(() {
                          Get.back();
                        }),
                      ],
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowMax
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
