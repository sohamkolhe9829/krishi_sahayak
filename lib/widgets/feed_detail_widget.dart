import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:krishi_sahayak/models/post_model.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:krishi_sahayak/screens/feed/post_detail.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';
import 'package:krishi_sahayak/widgets/net_image_widget.dart';
import 'package:provider/provider.dart';

import '../utils/functions.dart';

class FeedDetailWidget extends StatelessWidget {
  Post post;
  FeedDetailWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Consumer<FeedProvider>(
      builder: (context, feedProvider, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        CachedNetworkImageProvider(post.ownerProfile),
                  ),
                  title: Text(
                    post.ownerName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      "${formatDate(post.dateTime)} - ${timeAgo(post.dateTime)}"),
                  trailing: currentUser!.uid == post.ownerId
                      ? IconButton(
                          onPressed: () {
                            menuFunctions(context, post.postId);
                          },
                          icon: const Icon(Icons.more_vert_outlined),
                        )
                      : SizedBox(),
                ),
                SelectableLinkify(
                  onOpen: launchFeedURL,
                  text: post.content,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // const Text(
                //   "In the article, I have explained the basic structure of Read More in a flutter; you can modify this code according to your choice. This was a small introduction to Read More on user interaction from my side, and it’s working using Flutter.",
                //   style: TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                const SizedBox(height: 10),
                post.imageUrls.isEmpty
                    ? SizedBox()
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: PageView.builder(
                          itemCount: post.imageUrls.length,
                          itemBuilder: (context, index) {
                            return NetImageWidget(
                                imageURL: post.imageUrls[index]);
                          },
                        ),
                      ),
                Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(5),
                      onPressed: () {
                        feedProvider.likePost(post.postId, post.likes,
                            post.likes.contains(currentUser.uid));
                      },
                      icon: Icon(
                        post.likes.contains(currentUser.uid)
                            ? Icons.thumb_up_alt
                            : Icons.thumb_up_alt_outlined,
                        size: 30,
                      ),
                    ),
                    Text(
                      post.likes.length.toString(),
                      style: const TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Spacer(),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("user")
                            .doc(currentUser.uid)
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
                            List savedPosts = snapshot.data!.get('savedPosts');
                            return IconButton(
                              padding: const EdgeInsets.all(5),
                              onPressed: () {
                                if (savedPosts.contains(post.postId)) {
                                  feedProvider.savePost(post.postId, true);
                                } else {
                                  feedProvider.savePost(post.postId, false);
                                }
                              },
                              icon: Icon(
                                savedPosts.contains(post.postId)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                size: 30,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: post.comments.length,
            itemBuilder: (context, index) {
              final comment = post.comments[index];
              return Card(
                elevation: 2,
                surfaceTintColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              CachedNetworkImageProvider(comment.ownerProfile),
                        ),
                        title: Text(
                          comment.ownerName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${formatDate(comment.dateTime)} - ${timeAgo(comment.dateTime)}",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        comment.content,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  menuFunctions(BuildContext context, String postId) {
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ListTile(
            onTap: () {
              feedProvider.deletePost(context, postId);
            },
            leading: Icon(Icons.delete),
            title: Text("Delete post"),
          ),
        );
      },
    );
  }
}
