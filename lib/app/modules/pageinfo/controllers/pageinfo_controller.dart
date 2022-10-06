import 'package:dapp/app/modules/home/controllers/home_controller.dart';
import 'package:dapp/app/modules/home/services/interactSmartContract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageinfoController extends GetxController with StateMixin<List<dynamic>> {
  //TODO: Implement PageinfoController

  final count = 0.obs;
  HomeController _homeController = Get.put(HomeController());
  final candidateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getTotalCandidate();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    candidateController.dispose();
    _homeController.dispose();
  }

  void increment() => count.value++;
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void submitAddCandidate() {
    if (candidateController.text.isNotEmpty) {
      addCandidate(candidateController.text, _homeController.ethClient!)
          .then((value) {
        getTotalCandidate();
      });
    } else {
      Get.snackbar("error", 'candidate cant empty');
    }
  }

  void getTotalCandidate() {
    try {
      getCandidatesNumber(_homeController.ethClient!).then((value) {
        print(value);
        change(value, status: RxStatus.success());
      });
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
  // Future<List<dynamic>> getTotalCandidate() async {
  //   var response = await getCandidatesNumber(_homeController.ethClient!);
  //   return response;
  // }
}
