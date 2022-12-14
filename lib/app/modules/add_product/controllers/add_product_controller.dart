import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String name, String price) async {
    CollectionReference products = firestore.collection('products');

    try {
      String dateNow = DateTime.now().toIso8601String();
      await products.add({
        'name': name,
        'price':int.parse(price),
        'time': dateNow
      });
      Get.defaultDialog(
          title: 'Success',
          middleText: 'Product has been added',
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
          middleText: 'Failed to add product',
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
