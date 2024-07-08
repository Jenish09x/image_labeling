import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class HomeController extends GetxController {
  var image = RxnString();
  RxList labels = [].obs;
  final ImagePicker _picker = ImagePicker();
  final ImageLabeler _imageLabeler =
      ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.7));

  void showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Open Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      image.value = pickedFile.path;
      await labelImage(pickedFile.path);
    }
  }

  Future<void> labelImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final List<ImageLabel> imageLabels =
        await _imageLabeler.processImage(inputImage);
    labels.value = imageLabels.map((label)=>label.label).toList();
    // print(labels);
    // labels.value = imageLabels.map((label) => label.label).toList();
  }
}
