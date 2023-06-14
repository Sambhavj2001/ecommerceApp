import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/helper_widgets/applogo.dart';
import 'package:ecommerce_app/helper_widgets/background.dart';
import 'package:ecommerce_app/helper_widgets/customTextField.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
              Column(
                children: [
                  customTextField(title: name, hint: nameHint),
                  20.heightBox,
                  customTextField(title: email, hint: emailHint),
                  20.heightBox,
                  customTextField(title: password, hint: passwordHint),
                  20.heightBox,
                  customTextField(title: retypePass, hint: passwordHint),
                  20.heightBox,
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (newValue) {},
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I agree to the ',
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                ),
                              ),
                              TextSpan(
                                text: ' & ',
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: bold,
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
                  customButton(
                    title: sigup,
                    color: redColor,
                    textColor: whiteColor,
                    onPress: () {},
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey,
                          ),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          ),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.back();
                  }),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowMax
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
