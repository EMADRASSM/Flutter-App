import 'package:emart_app/consts/consts.dart';

Widget detailsCart({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text
          .softWrap(false)
          .color(darkFontGrey)
          .fontFamily(semibold)
          .make(),
    ],
  )
      .box
      .white
      .roundedSM
      .width(width)
      .height(70)
      .padding(const EdgeInsets.all(4))
      .make();
}
