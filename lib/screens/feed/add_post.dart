import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

class AddFeedPost extends StatefulWidget {
  const AddFeedPost({super.key});

  @override
  State<AddFeedPost> createState() => _AddFeedPostState();
}

class _AddFeedPostState extends State<AddFeedPost> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController contentController = TextEditingController();
    return Consumer<FeedProvider>(
      builder: (context, feedProvider, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Post"),
            leading: IconButton(
                onPressed: () {
                  feedProvider.clearData();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      feedProvider.pickMultipleImages();
                    },
                    child: const Chip(
                      label: Icon(Icons.image),
                    ),
                  ),
                  feedProvider.selectedFiles.isEmpty
                      ? const SizedBox()
                      : AspectRatio(
                          aspectRatio: 16 / 9,
                          child: PageView.builder(
                            itemCount: feedProvider.selectedFiles.length,
                            itemBuilder: (context, index) {
                              return Image.file(
                                feedProvider.selectedFiles[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: contentController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write somthing here........",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor("#137547")),
                      ),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        feedProvider.addPost(
                          context,
                          contentController.text,
                        );
                      },
                      child: isLoading
                          ? const CustomCircularLoading()
                          : const Text(
                              "Add Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
