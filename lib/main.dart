import 'package:d_firebase/app/controllers/auth_controller.dart';
import 'package:d_firebase/app/modules/home/views/home_view.dart';
import 'package:d_firebase/app/modules/login/views/login_view.dart';
import 'package:d_firebase/app/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.QUERY,
      getPages: AppPages.routes,
      // home: snapshot.data != null ? HomeView() : LoginView(),
    );

//     return StreamBuilder<User?>(
//       stream: authC.streamAuthStatus,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           print(snapshot.data);

//           return GetMaterialApp(
//             title: "Application",
//             initialRoute:
//                 snapshot.data != null && snapshot.data!.emailVerified == true
//                     ? Routes.HOME
//                     : Routes.LOGIN,
//             getPages: AppPages.routes,
//             // home: snapshot.data != null ? HomeView() : LoginView(),
//           );
//         }
//         return LoadingView();
//       },
//     );
//   }
// }
  }
}
