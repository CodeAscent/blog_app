import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:get/get.dart';

void customSnackbar(String? message) {
  Get.closeCurrentSnackbar();
  Get.snackbar(
      "Message", message ?? "Something went wrong!\nPlease try again later.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: primaryColor(),
      shouldIconPulse: true,
      progressIndicatorBackgroundColor: inversePrimaryColor(),
      isDismissible: true);
}
