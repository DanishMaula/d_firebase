import 'package:d_firebase/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login(String pmail, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: pmail, password: password);
      if (myUser.user!.emailVerified == true) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
            title: 'Verification Email',
            middleText: 'Do you want to resend verification email?',
            onConfirm: () async {
              await myUser.user!.sendEmailVerification();
              Get.back();
            },
            textConfirm: 'Yes',
            textCancel: 'Back');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        Get.defaultDialog(
          title: 'Error Occured',
          middleText: 'No user found for that email',
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
        Get.defaultDialog(
          title: 'Error Occured',
          middleText: 'Wrong password provided for that user',
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error Occured',
        middleText: 'Cannot login, please try again',
      );
    }
  }

  void signup(String pmail, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
          email: pmail, password: password);
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
          title: 'Verification Email',
          middleText: 'We have sent you a verification email',
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: 'Ok');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.defaultDialog(
          title: 'Error Occured',
          middleText: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.defaultDialog(
          title: 'Error Occured',
          middleText: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Error Occured',
        middleText: 'Cant create account',
      );
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try{
        auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: 'Success!',
          middleText: 'We have sent you a reset password email $email',
          onConfirm: (){
            Get.back(); // close dialog
            Get.back(); // go to login
          },
          
          textConfirm: "Ok",
        );

      }catch (e){
        Get.defaultDialog(
          title: 'Error Occured',
          middleText: 'Cant reset password',
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Error Occured',
        middleText: 'Please enter your email',
      );
    }
  }
}
