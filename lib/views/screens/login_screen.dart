import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/helper_widgets/applogo.dart';
import 'package:ecommerce_app/helper_widgets/background.dart';
import 'package:ecommerce_app/helper_widgets/customTextField.dart';
import 'package:ecommerce_app/helper_widgets/custom_button.dart';
import 'package:ecommerce_app/views/screens/home_structure.dart';
import 'package:ecommerce_app/views/screens/signup_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              'Log in to $appname'
                  .text
                  .white
                  .fontFamily(semibold)
                  .size(18)
                  .make(),
              25.heightBox,
              Column(
                children: [
                  customTextField(title: email, hint: emailHint),
                  20.heightBox,
                  customTextField(title: password, hint: passwordHint),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                  customButton(
                    title: login,
                    color: redColor,
                    textColor: whiteColor,
                    onPress: () {
                      Get.to(
                        () => Home(),
                      );
                    },
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  10.heightBox,
                  customButton(
                    title: sigup,
                    color: lightGolden,
                    textColor: Colors.black,
                    onPress: () {
                      Get.to(
                        () => SignUpScreen(),
                      );
                    },
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => CircleAvatar(
                        radius: 25,
                        backgroundColor: lightGrey,
                        child: Image.asset(
                          socialIconList[index],
                          width: 30,
                        ),
                      ),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
