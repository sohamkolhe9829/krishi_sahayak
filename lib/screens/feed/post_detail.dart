import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:krishi_sahayak/widgets/feed_detail_widget.dart';
import 'package:provider/provider.dart';

import '../../models/post_model.dart';
import '../../widgets/custom_loading.dart';

class PostDetailScreen extends StatelessWidget {
  String postId;
  PostDetailScreen({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .doc(postId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const CustomCircularLoading();
                } else if (!snapshot.hasData) {
                  return const CustomCircularLoading();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CustomCircularLoading();
                } else {
                  final data = snapshot.data;
                  return FeedDetailWidget(
                    post: Post(
                      postId: data!.id,
                      ownerName: data.get("ownerName"),
                      ownerProfile: data.get("ownerProfile"),
                      ownerId: data.get("ownerId"),
                      dateTime: data.get("dateTime").toDate(),
                      content: data.get("content"),
                      imageUrls: data.get("imageUrls") as List,
                      likes: data.get("likes") as List,
                      comments: (data.get('comments') as List<dynamic>)
                          .cast<Map<String, dynamic>>()
                          .map((commentData) => Comment.fromMap(commentData))
                          .toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: commentController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Comment something.....",
              suffixIcon: IconButton(
                onPressed: () {
                  final feedProvider =
                      Provider.of<FeedProvider>(context, listen: false);
                  feedProvider.commentPost(postId, commentController.text);
                  commentController.clear();
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
