import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference products = firestore.collection('products');

    return products.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection('products');
    return products.where(
      'price', isGreaterThan: 10000)
      .snapshots();
  }

  void deleteProduct(String docId) async {
    DocumentReference docRef = firestore.collection('products').doc(docId);
    try {
      Get.defaultDialog(
          title: 'Yakin ngab?',
          middleText: 'Are you sure to delete this product?',
          textConfirm: "Yes",
          textCancel: 'No',
          onConfirm:() async {
            await docRef.delete();
            Get.back();
          }
          );
    } catch (e) {
      print('Error : $e');
      Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to delete product',
          textConfirm: "Ok");
    }
  }
}
