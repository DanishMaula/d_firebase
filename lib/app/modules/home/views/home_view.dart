import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_firebase/app/controllers/auth_controller.dart';
import 'package:d_firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => authC.logout(), icon: Icon(Icons.logout))
        ],

        /** One Time Read Data */
      ),
      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //     future: controller.getData(),
      // builder: (context, snapshot) {
      //   if(snapshot.connectionState == ConnectionState.done){
      //     var listAllDoc = snapshot.data!.docs;
      //     return ListView.builder(
      //     itemCount: listAllDoc.length,
      //     itemBuilder: (context, index) => ListTile(
      //       title: Text('${listAllDoc[index]['name']}'),
      //       subtitle: Text('Rp ${listAllDoc[index]['price']}'),
      //     ),
      //   );
      //   }
      //   return Center(child: CircularProgressIndicator());
      // },
      //     ),

      /** Realtime Read Data */
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDoc = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllDoc.length,

              itemBuilder: (context, index) {
                if((listAllDoc[index].data() as Map<String, dynamic>)['price'] >= 10000){
                  return ListTile(
                onTap: () => Get.toNamed(Routes.EDIT_PRODUCT,
                    arguments: listAllDoc[index].id),

                title: Text(
                  '${(listAllDoc[index].data() as Map<String, dynamic>)['name']}',
                  ),

                subtitle: Text(
                  'Rp ${(listAllDoc[index].data() as Map<String, dynamic>)['price']}',
                  ),
                  trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () =>
                      controller.deleteProduct(listAllDoc[index].id),
                ),
                  );
                }
                return SizedBox();
              }
             
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
        child: Icon(Icons.add),
      ),
    );
  }
}
