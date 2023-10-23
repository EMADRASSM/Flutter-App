import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/account_controller.dart';
import 'package:get/get.dart';

class EditAccountScreen extends StatelessWidget {
  final dynamic data;
  const EditAccountScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    //  instance of the AccountController class
    var controller = Get.find<AccountController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        // THE OBX Widget use for Observe UI and it is used to reactively update the UI when variables change .
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if data image url and controller path is empty
              data['imageUrl'] == '' && controller.accountImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :
                  // if data image url is not empty but controller path is empty
                  data['imageUrl'] != '' && controller.accountImagePath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      :
                      // if both are empty .
                      Image.file(
                          File(controller.accountImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change",
              ),
              const Divider(),
              20.heightBox,
              customTextField(
                fieldTitle: name,
                fieldHint: nameHint,
                isPass: false,
                controller: controller.nameController,
              ),
              10.heightBox,
              customTextField(
                fieldTitle: oldpass,
                fieldHint: passwordHint,
                isPass: true,
                controller: controller.oldPassController,
              ),
              10.heightBox,
              customTextField(
                fieldTitle: newpass,
                fieldHint: passwordHint,
                isPass: true,
                controller: controller.newPassController,
              ),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isloading(true);

                          // if image is not selected
                          if (controller.accountImagePath.value.isNotEmpty) {
                            await controller.uploadAccountImage();
                          } else {
                            controller.accountImageLink = data['imageUrl'];
                          }

                          // if old password matches database
                          if (data['password'] ==
                              controller.oldPassController.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldPassController.text,
                              newPassword: controller.newPassController.text,
                            );

                            await controller.updateAccount(
                              name: controller.nameController.text,
                              password: controller.newPassController.text,
                              imageUrl: controller.accountImageLink,
                            );
                            // ignore: use_build_context_synchronously
                            VxToast.show(context, msg: "Updated");
                          } else {
                            // ignore: use_build_context_synchronously
                            VxToast.show(context, msg: "Wrong old password");
                            controller.isloading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save",
                      ),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    );
  }
}
