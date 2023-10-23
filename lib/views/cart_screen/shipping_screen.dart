import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_screen.dart';
import 'package:get/get.dart';

class ShippingDetailes extends StatelessWidget {
  const ShippingDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                customTextField(
                    fieldHint: 'Address',
                    isPass: false,
                    fieldTitle: 'Address',
                    controller: controller.addressController),
                customTextField(
                    fieldHint: 'City',
                    isPass: false,
                    fieldTitle: 'City',
                    controller: controller.cityController),
                customTextField(
                    fieldHint: 'State',
                    isPass: false,
                    fieldTitle: 'State',
                    controller: controller.stateController),
                customTextField(
                    fieldHint: 'Postal Code',
                    isPass: false,
                    fieldTitle: 'Postal Code',
                    controller: controller.postalcodeController),
                customTextField(
                    fieldHint: 'Phone',
                    isPass: false,
                    fieldTitle: 'Phone',
                    controller: controller.phoneController),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          textColor: whiteColor,
          onPress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: 'Please fill the form');
            }
          },
          title: "Continue",
        ),
      ),
    );
  }
}
