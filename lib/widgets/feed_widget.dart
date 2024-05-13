import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gtext/gtext.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:krishi_sahayak/models/post_model.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:krishi_sahayak/screens/feed/post_detail.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';
import 'package:krishi_sahayak/widgets/image_preview.dart';
import 'package:krishi_sahayak/widgets/net_image_widget.dart';
import 'package:provider/provider.dart';

import '../utils/functions.dart';

// ignore: must_be_immutable
class FeedWidget extends StatelessWidget {
  Post post;
  FeedWidget({
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                          postId: post.postId,
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        CachedNetworkImageProvider(post.ownerProfile),
                  ),
                  title: Text(
                    post.ownerName,
                    textAlign: TextAlign.start,
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
                      : const SizedBox(),
                ),
                // SelectableLinkify(
                //   onOpen: launchFeedURL,
                //   text: post.content,
                //   textAlign: TextAlign.start,
                //   style: const TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                GText(
                  post.content,
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
                    ? const SizedBox()
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: PageView.builder(
                          itemCount: post.imageUrls.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ImagePreviewWidget(
                                            imageURL: post.imageUrls[index],
                                            title: post.ownerName)));
                              },
                              child: NetImageWidget(
                                  imageURL: post.imageUrls[index]),
                            );
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
                        size: 27,
                      ),
                    ),
                    Text(
                      post.likes.length.toString(),
                      style: const TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      padding: const EdgeInsets.all(5),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(
                              postId: post.postId,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.chat_bubble,
                        size: 27,
                      ),
                    ),
                    const Spacer(),
                    BookmarkIconButton(post: post),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
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
            leading: const Icon(Icons.delete),
            title: const Text("Delete post"),
          ),
        );
      },
    );
  }
}

class BookmarkIconButton extends StatelessWidget {
  final Post post;

  const BookmarkIconButton({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("user")
          .doc(currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const CustomCircularLoading();
        } else {
          List savedPosts = snapshot.data!.get('savedPosts');
          return IconButton(
            padding: const EdgeInsets.all(5),
            onPressed: () {
              if (savedPosts.contains(post.postId)) {
                feedProvider.savePost(post.postId, false);
              } else {
                feedProvider.savePost(post.postId, true);
              }
            },
            icon: Icon(
              savedPosts.contains(post.postId)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              size: 27,
            ),
          );
        }
      },
    );
  }
}
