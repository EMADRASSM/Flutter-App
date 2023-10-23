import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/theme_controller.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/account_screen/components/details_cart.dart';
import 'package:emart_app/views/account_screen/edit_account_screen.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/controller/account_controller.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/orders_screen/orders_screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AccountController());
    final ThemeController themeController = Get.find();

    return bgWidget(
      child: Scaffold(
        // the StreamBuilder widget is used to rebuild parts of the user interface in response to new data events emitted by a Stream.
        body: StreamBuilder(
            // This is the Stream you want to listen to for data changes. It can be any type of Stream, such as Stream<int>, Stream<String>, or even custom data streams.
            stream: FirestorServices.getUser(currentUser!.uid),

            // builder: This is a callback function that defines what the UI should look like based on the data received from the Stream.
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                /*
                   it appears that the snapshot.data is expected to be of type QuerySnapshot.
                   The .docs property of the QuerySnapshot returns a list of QueryDocumentSnapshot, representing the documents retrieved from the Firestore query. 
                */
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Column(
                    children: [
                      //edit profile button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                              ),
                            ).onTap(() {
                              // Here to show user information in textfields .
                              controller.nameController.text = data['name'];
                              Get.to(() => EditAccountScreen(data: data));
                            }),
                            20.widthBox,
                            GestureDetector(
                              onTap: () {
                                themeController.toggleTheme();
                              },
                              child: Obx(() {
                                final isDarkMode =
                                    themeController.isDarkMode.value;
                                return Icon(
                                  isDarkMode
                                      ? Icons.brightness_5
                                      : Icons.brightness_3,
                                  color: whiteColor,
                                );
                              }),
                            )
                          ],
                        ),
                      ),

                      20.heightBox,

                      // user details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                    width: 80,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            5.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ' ${data['name']}'
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: whiteColor,
                                ),
                              ),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child:
                                  logout.text.fontFamily(semibold).white.make(),
                            ),
                          ],
                        ),
                      ),

                      20.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCart(
                            width: context.screenWidth / 3.4,
                            count: data['cart_count'],
                            title: "in your cart",
                          ),
                          detailsCart(
                            width: context.screenWidth / 3.4,
                            count: data['wishlist_count'],
                            title: "in your wishlist",
                          ),
                          detailsCart(
                            width: context.screenWidth / 3.4,
                            count: data['order_count'],
                            title: "your orders",
                          ),
                        ],
                      ),

                      // 40.heightBox,

                      // buttons section
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(color: lightGrey);
                        },
                        itemCount: accountButtonsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const WishlistScreen());
                                  break;
                                case 1:
                                  Get.to(() => const OrdersScreen());
                                  break;
                                case 2:
                                  Get.to(() => const MessagesScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              accountButtonsIcon[index],
                              width: 22,
                              fit: BoxFit.contain,
                            ),
                            title: accountButtonsList[index]
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
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .margin(const EdgeInsets.all(12))
                          .make()
                          .box
                          // .color(redColor)
                          .make(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
