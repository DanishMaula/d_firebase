import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docId) async {
    DocumentReference docRef =
        firestore.collection('products').doc(docId);
    return await docRef.get();
  }

  void addProduct(String name, String price, String docId) async {
    DocumentReference docData = firestore.collection('products').doc(docId);

    try {
      await docData.update({
        'name': name,
        'price': int.parse(price),
      });
      Get.defaultDialog(
          title: 'Success',
          middleText: 'Product has been updated',
          onConfirm: () {
            nameC.clear();
            priceC.clear();
            Get.back();
            Get.back();
          },
          textConfirm: "Ok",
          confirmTextColor: Colors.white);
    } catch (e) {
      print('Error : $e');
      Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to up',
          textConfirm: "Ok");
    }
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameC.dispose();
    priceC.dispose();
    super.dispose();
  }
}
