import 'package:dapp/app/modules/home/services/interactSmartContract.dart';
import 'package:dapp/app/modules/pageinfo/views/pageinfo_view.dart';
import 'package:dapp/app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  Client? httpClient;
  Web3Client? ethClient;
  final addressController = TextEditingController();
  final homeFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    httpClient = Client();
    ethClient = Web3Client(infuraUrl, httpClient!);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
  }

  void startVote() async {
    if (addressController.text.length > 0) {
      // await startVoting(addressController.text, ethClient!);
      Get.toNamed('/pageinfo');
    } else {
      Get.snackbar('Failed', 'field cant be empty');
    }
  }

  void increment() => count.value++;
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }
}
