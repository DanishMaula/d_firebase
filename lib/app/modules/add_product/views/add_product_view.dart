import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: controller.nameC,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Product Name',
              ),
            ),
            TextField(
              controller: controller.priceC,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Product Price',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.addProduct(controller.nameC.text, controller.priceC.text),
              child: Text('Add Product'),
            ),
          ],
        ),
      )
    );
  }
}
