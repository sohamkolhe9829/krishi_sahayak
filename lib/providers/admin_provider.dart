import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_sahayak/utils/functions.dart';

class AdminProvider with ChangeNotifier {
  List<File> selectedFiles = [];
  void pickMultipleImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      for (var i = 0; i < images.length; i++) {
        selectedFiles.add(File(images[i].path));
      }
    } else {}
    notifyListeners();
  }

  File? selectedImage;

  void pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image!.path.isNotEmpty) {
      selectedImage = File(image!.path);
    } else {}
    notifyListeners();
  }

  Future<List<String>> uploadImages(List<File> images) async {
    final List<String> downloadUrls = [];
    for (final image in images) {
      final reference = FirebaseStorage.instance
          .ref()
          .child('AppData/${image.path.split('/').last}');
      final uploadTask = reference.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      downloadUrls.add(url);
    }

    return downloadUrls;
  }

  Future<String> uploadImageToFirebase(File image) async {
    final reference = FirebaseStorage.instance
        .ref()
        .child('AppData/${image.path.split('/').last}');
    final uploadTask = reference.putFile(image);
    final snapshot = await uploadTask.whenComplete(() => null);

    return await snapshot.ref.getDownloadURL();
  }

  addSeasonalCropInformation(
      BuildContext context, String title, String content) async {
    try {
      showLoadingWidget(context);
      uploadImages(selectedFiles).then((value) async {
        value.isEmpty
            ? await FirebaseFirestore.instance
                .collection("seasonal_crops")
                .doc(title.toLowerCase())
                .update({
                "content": content,
              }).then((value) {
                Fluttertoast.showToast(msg: "Data uploaded");
                clearData();
                Navigator.pop(context);
                Navigator.pop(context);
              })
            : await FirebaseFirestore.instance
                .collection("seasonal_crops")
                .doc(title.toLowerCase())
                .update({
                "content": content,
                "imageURLs": value,
              }).then((value) {
                Fluttertoast.showToast(msg: "Data uploaded");
                clearData();
                Navigator.pop(context);
                Navigator.pop(context);
              });
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }

  addCropsInformation(
      BuildContext context, String title, String content) async {
    try {
      showLoadingWidget(context);
      uploadImageToFirebase(selectedImage!).then((singleImage) async {
        uploadImages(selectedFiles).then((imageUrls) async {
          imageUrls.isEmpty
              ? await FirebaseFirestore.instance
                  .collection("crops_informations")
                  .add({
                  "title": title,
                  "content": content,
                  "bannerUrl": singleImage,
                }).then((value) {
                  Fluttertoast.showToast(msg: "Data uploaded");
                  clearData();
                  Navigator.pop(context);
                  Navigator.pop(context);
                })
              : await FirebaseFirestore.instance
                  .collection("crops_informations")
                  .add({
                  "title": title,
                  "content": content,
                  "imageURLs": imageUrls,
                  "bannerUrl": singleImage,
                }).then((value) {
                  Fluttertoast.showToast(msg: "Data uploaded");
                  clearData();
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
        });
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }

  updateCropsInformation(
      BuildContext context, String title, String content, String docId) async {
    try {
      showLoadingWidget(context);
      uploadImageToFirebase(selectedImage!).then((singleImage) async {
        uploadImages(selectedFiles).then((imageUrls) async {
          selectedImage == null
              ? imageUrls.isEmpty
                  ? await FirebaseFirestore.instance
                      .collection("crops_informations")
                      .doc(docId)
                      .update({
                      "title": title,
                      "content": content,
                    }).then((value) {
                      Fluttertoast.showToast(msg: "Data uploaded");
                      clearData();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
                  : await FirebaseFirestore.instance
                      .collection("crops_informations")
                      .doc(docId)
                      .update({
                      "title": title,
                      "content": content,
                      "imageURLs": imageUrls,
                    }).then((value) {
                      Fluttertoast.showToast(msg: "Data uploaded");
                      clearData();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              : imageUrls.isEmpty
                  ? await FirebaseFirestore.instance
                      .collection("crops_informations")
                      .doc(docId)
                      .update({
                      "title": title,
                      "content": content,
                      "bannerUrl": singleImage,
                    }).then((value) {
                      Fluttertoast.showToast(msg: "Data uploaded");
                      clearData();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
                  : await FirebaseFirestore.instance
                      .collection("crops_informations")
                      .doc(docId)
                      .update({
                      "title": title,
                      "content": content,
                      "imageURLs": imageUrls,
                      "bannerUrl": singleImage,
                    }).then((value) {
                      Fluttertoast.showToast(msg: "Data uploaded");
                      clearData();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
        });
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }

  clearData() {
    selectedFiles = [];
    selectedImage = null;
    notifyListeners();
  }
}
