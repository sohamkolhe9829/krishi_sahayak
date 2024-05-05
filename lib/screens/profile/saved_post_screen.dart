import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sahayak/models/post_model.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';
import 'package:krishi_sahayak/widgets/feed_widget.dart';
import 'package:provider/provider.dart';

class SavedPostScreen extends StatelessWidget {
  const SavedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Consumer<FeedProvider>(
      builder: (context, feedProvider, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Saved"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              )),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(currentUser!.uid)
                  .snapshots(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasError) {
                  return const CustomCircularLoading();
                } else if (!userSnapshot.hasData) {
                  return const CustomCircularLoading();
                } else if (userSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CustomCircularLoading();
                }
                return SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    cacheExtent: 10000.0,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userSnapshot.data!.get("savedPosts").length,
                    itemBuilder: (context, index) {
                      final savedPosts = userSnapshot.data!.get('savedPosts');

                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("posts")
                            .where("postId", isEqualTo: savedPosts[index])
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
                            return SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                cacheExtent: 10000.0,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];

                                  return FeedWidget(
                                    post: Post(
                                      postId: data.id,
                                      ownerName: data.get("ownerName"),
                                      ownerProfile: data.get("ownerProfile"),
                                      ownerId: data.get("ownerId"),
                                      dateTime: data.get("dateTime").toDate(),
                                      content: data.get("content"),
                                      imageUrls: data.get("imageUrls") as List,
                                      likes: data.get("likes") as List,
                                      comments: (data.get('comments')
                                              as List<dynamic>)
                                          .cast<Map<String, dynamic>>()
                                          .map((commentData) =>
                                              Comment.fromMap(commentData))
                                          .toList(),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
