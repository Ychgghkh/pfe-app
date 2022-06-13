import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled19/Authentication/Sign_in/my_login.dart';

class OnBoardingController extends GetxController {
  RememberUser(Map user, int index) {
    var storage = GetStorage();
    token(index);
    storage.write("user", {
      'uid': user['uid'],
      'userName': user['userName'],
      'email': user['email'],
      'gsm': user['gsm'],
    });
  }

  token(int index) {
    var storage = GetStorage();
    storage.write("auth", 1);
    storage.write("type_auth", index);
  }

  Logout() async {
    var storage = GetStorage();
    storage.write("auth", 0);
    storage.remove("user");
    Get.to(MyLogin());
  }
}
