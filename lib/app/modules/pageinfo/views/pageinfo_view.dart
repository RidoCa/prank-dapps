import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';

import '../controllers/pageinfo_controller.dart';

class PageinfoView extends GetView<PageinfoController> {
  late final Web3Client ethCLient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageinfoView'),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                controller.obx(
                  (state) => Column(
                    children: [
                      Text(state![0].toString()),
                      Text(
                        'Total Candidates',
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text('hah'),
                    Text(
                      'Total Votes',
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.candidateController,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: controller.validator,
                  ),
                ),
                ElevatedButton(
                    onPressed: () => controller.submitAddCandidate(),
                    child: Text('Submit'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
