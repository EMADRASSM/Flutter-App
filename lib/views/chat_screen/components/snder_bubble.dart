import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

//
Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat('h:mma').format(t);

  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 6, 3),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor : msgBackground,
        borderRadius: data['uid'] == currentUser!.uid
            ? const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(0),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(12),
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: data['uid'] == currentUser!.uid
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 250),
            child: "${data['msg']}"
                .text
                .color(
                  data['uid'] == currentUser!.uid ? whiteColor : msgTextColor,
                )
                .size(16)
                .make()
                .box
                .margin(const EdgeInsets.only(bottom: 5))
                .make(),
          ),
          time.text
              .size(12)
              .color(
                data['uid'] == currentUser!.uid
                    ? whiteColor.withOpacity(.5)
                    : msgTextColor.withOpacity(.5),
              )
              .make()
              .box
              .height(15)
              .make(),
        ],
      ),
    ),
  );
}
