import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sahayak/models/post_model.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:krishi_sahayak/screens/feed/add_post.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';
import 'package:krishi_sahayak/widgets/feed_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(
      builder: (context, feedProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Feed"),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddFeedPost(),
              ),
            );
          },
          label: const Text("Add Post"),
          icon: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const CustomCircularLoading();
              } else if (!snapshot.hasData) {
                return const CustomCircularLoading();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
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
                          comments: (data.get('comments') as List<dynamic>)
                              .cast<Map<String, dynamic>>()
                              .map(
                                  (commentData) => Comment.fromMap(commentData))
                              .toList(),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
