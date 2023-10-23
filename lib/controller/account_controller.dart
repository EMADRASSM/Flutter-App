import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AccountController extends GetxController {
  // The obs make the variable obsevable from Obx widget .
  var accountImagePath = ''.obs;

  var accountImageLink = "";

  var isloading = false.obs;

  var nameController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      accountImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadAccountImage() async {
    /*  It retrieves the filename from the full path of the account image file. 
        The basename() function is commonly used to extract the filename from a path.*/
    var filename = basename(accountImagePath.value);

    /*  It defines the destination path where the image will be stored in Firebase Storage. 
        It seems to use the user's unique identifier (UID) and the filename to create a specific path for each user's image. 
    */
    var destination = 'images/${currentUser!.uid}/$filename';

    /* It creates a Firebase Storage reference with the specified destination path, 
    which represents the location where the image file will be stored. */
    Reference ref = FirebaseStorage.instance.ref().child(destination);

    /*
  It uploads the image file to Firebase Storage using the putFile() method. 
  The accountImagePath.value variable likely holds the full path to the local image file on the device.
  The await keyword indicates that the function will wait for the upload process to complete before proceeding to the next step. 
  */
    await ref.putFile(File(accountImagePath.value));

    /*
  Once the image is successfully uploaded, it fetches the download URL of the uploaded image using the getDownloadURL() method on the Reference object.
  The await keyword again indicates that the function will wait for the download URL retrieval to complete.
  */
    accountImageLink = await ref.getDownloadURL();
  }

  updateAccount({name, password, imageUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
    isloading(false);
  }

  changeAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
    });
  }
}
