import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/reset_controller.dart';

class ResetView extends GetView<ResetController> {
final authC = Get.find<AuthController>();

  @override
   Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              TextField(
                controller: controller.emailC,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () => authC.resetPassword(controller.emailC.text),
                  child: Text('Reset')),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah punya akun?'),
                      TextButton(onPressed: () => Get.back(), child: Text('Login'))
                    ],
                  )
    
            ],
          ),
        )
        );
  }
}
