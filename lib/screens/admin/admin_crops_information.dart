import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sahayak/screens/admin/add_crops_information.dart';
import 'package:krishi_sahayak/screens/admin/edit_crops_information.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';

class AdminCropsInformations extends StatelessWidget {
  const AdminCropsInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crops Information"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => AddCropsInformation()));
        },
        label: const Text("Add Crop Information"),
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("crops_informations")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const CustomCircularLoading();
            } else if (!snapshot.hasData) {
              return const CustomCircularLoading();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomCircularLoading();
            } else {
              return SingleChildScrollView(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  cacheExtent: 10000.0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return HomeCardWidget(
                      imageURL: data.get('bannerUrl'),
                      title: data.get('title'),
                      content: data.get('content'),
                      docId: data.id,
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HomeCardWidget extends StatelessWidget {
  String title;
  String imageURL;
  String content;
  String docId;
  HomeCardWidget({
    super.key,
    required this.imageURL,
    required this.title,
    required this.content,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EditCropsInformations(
            title: title,
            content: content,
            docId: docId,
          ),
        ),
      ),
      child: Container(
        height: 100,
        width: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageURL),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.srcOver,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
