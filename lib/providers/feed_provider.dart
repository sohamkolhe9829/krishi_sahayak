import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_sahayak/screens/home_container.dart';

import '../models/post_model.dart';

class FeedProvider with ChangeNotifier {
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

  Future<List<String>> uploadImages(List<File> images) async {
    final List<String> downloadUrls = [];
    for (final image in images) {
      final reference = FirebaseStorage.instance
          .ref()
          .child('Feed/${image.path.split('/').last}');
      final uploadTask = reference.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      downloadUrls.add(url);
    }

    return downloadUrls;
  }

  addPost(BuildContext context, String reContent) async {
    try {
      uploadImages(selectedFiles).then((value) async {
        final currentUser = FirebaseAuth.instance.currentUser;
        Post post = Post(
          postId: "",
          ownerName: currentUser!.displayName!,
          ownerProfile: currentUser.photoURL!,
          ownerId: currentUser.uid,
          dateTime: DateTime.now(),
          content: reContent,
          imageUrls: value,
          likes: [],
          comments: [],
        );
        await FirebaseFirestore.instance
            .collection("posts")
            .add(post.toMap())
            .then((value) async {
          await FirebaseFirestore.instance
              .collection("posts")
              .doc(value.id)
              .update({
            "postId": value.id,
          }).then((value) {
            Fluttertoast.showToast(msg: "Post uploaded successfully");
            clearData();
            Navigator.pop(context);
          });
        });
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }

  //Post actions
  final currentUser = FirebaseAuth.instance.currentUser;

  likePost(String postId, List likes, bool isLiked) async {
    if (isLiked) {
      try {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postId)
            .update({
          "likes": FieldValue.arrayRemove([currentUser!.uid]),
        });
      } catch (e) {
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postId)
            .update({
          "likes": FieldValue.arrayUnion([currentUser!.uid]),
        });
      } catch (e) {
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    }
    notifyListeners();
  }

  commentPost(String postId, String content) async {
    try {
      final comment = Comment(
          content: content,
          ownerName: currentUser!.displayName!,
          ownerProfile: currentUser!.photoURL!,
          commenterId: currentUser!.uid,
          dateTime: DateTime.now());
      await FirebaseFirestore.instance.collection("posts").doc(postId).update({
        "comments": FieldValue.arrayUnion([comment.toMap()]),
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }

  savePost(String postId, bool isSaved) async {
    if (isSaved) {
      try {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currentUser!.uid)
            .update({
          "savedPosts": FieldValue.arrayRemove([postId]),
        });
      } catch (e) {
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currentUser!.uid)
            .update({
          "savedPosts": FieldValue.arrayUnion([postId]),
        });
      } catch (e) {
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    }
    notifyListeners();
  }

  deletePost(BuildContext context, String postId) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .delete()
        .then((value) {
      Fluttertoast.showToast(msg: "Post deleted");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => HomeContainer(
                    index: 1,
                  )),
          (route) => false);
    });
    notifyListeners();
  }

  clearData() {
    selectedFiles = [];

    notifyListeners();
  }
}
