import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_labeling/screen/home/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.labels.clear();
                    controller.showImagePickerDialog(context);
                  },
                  child: Container(
                    height: 400,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: controller.image.value == null
                        ? const Icon(Icons.camera)
                        : Image.file(
                            File(controller.image.value!),
                          ),
                  ),
                ),
                if (controller.labels.isNotEmpty)
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemCount: controller.labels.length,
                        itemBuilder: (context, index) => Center(child: Text("${controller.labels[index]}")),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
