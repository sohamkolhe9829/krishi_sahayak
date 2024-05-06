import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:krishi_sahayak/screens/admin/add_seasonal_crop.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../widgets/net_image_widget.dart';

// ignore: must_be_immutable
class ViewSeasonalCrop extends StatelessWidget {
  String title;

  ViewSeasonalCrop({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("seasonal_crops")
            .doc(title.toLowerCase())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CustomCircularLoading();
          } else if (!snapshot.hasData) {
            return const CustomCircularLoading();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomCircularLoading();
          }
          final data = snapshot.data;

          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddSeasonalCropScreen(
                      title: title,
                      content: data!.get('content'),
                    ),
                  ),
                );
              },
              label: Text("Edit"),
              icon: Icon(Icons.edit),
            ),
            appBar: AppBar(
              title: Text(title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  data!.get('imageURLs').isEmpty
                      ? const SizedBox()
                      : AspectRatio(
                          aspectRatio: 16 / 9,
                          child: PageView.builder(
                            itemCount: data.get('imageURLs').length,
                            itemBuilder: (context, index) {
                              return NetImageWidget(
                                  imageURL: data.get('imageURLs')[index]);
                            },
                          ),
                        ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Html(
                      data: "${data.get('content')}",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
