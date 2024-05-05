import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:krishi_sahayak/screens/admin/add_seasonal_crop.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome back,",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    "Admin",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Card(
                      child: Center(
                        child: Text("Whether reports here...."),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Seasonal crop recommendations",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddSeasonalCropScreen(title: "Winter"),
                              ),
                            );
                          },
                          child: HomeCardWidget(
                            imageURL:
                                "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/winter.jfif?alt=media&token=4ba81afe-6d4d-417a-ae11-b1eade32a375",
                            title: "Winter",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddSeasonalCropScreen(title: "Summer"),
                              ),
                            );
                          },
                          child: HomeCardWidget(
                            imageURL:
                                "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/summer.jpg?alt=media&token=c404a700-e8bb-4f99-8108-b5d829e5f2b4",
                            title: "Summer",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddSeasonalCropScreen(title: "Monsoon"),
                              ),
                            );
                          },
                          child: HomeCardWidget(
                            imageURL:
                                "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/monsoon.jfif?alt=media&token=cd55dbf1-fdbb-48df-92b1-1e91daa5468a",
                            title: "Monsoon",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Crops Informations",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HomeCardWidget(
                          imageURL:
                              "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/banana.jfif?alt=media&token=4eab6ffd-7262-4e27-b2cb-c315669074da",
                          title: "Banana",
                        ),
                        HomeCardWidget(
                          imageURL:
                              "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/wheat.jfif?alt=media&token=9aaf4d7d-c72a-4e4b-970e-02b863be6ed0",
                          title: "Wheat",
                        ),
                        HomeCardWidget(
                          imageURL:
                              "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/cotton.jfif?alt=media&token=3914e649-11f6-4f40-9771-70b78e87ef1a",
                          title: "Cotton",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Crop Management Tools",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HomeCardWidget(
                          imageURL:
                              "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/loan%20calculator.png?alt=media&token=c89b687f-f69e-4da7-b4b5-a67758e9447a",
                          title: "Loan Calculations",
                        ),
                        HomeCardWidget(
                          imageURL:
                              "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/transport.png?alt=media&token=23a5d9b8-d585-4d51-a3e9-02eabaff093a",
                          title: "Transport Calculations",
                        ),
                        HomeCardWidget(
                          imageURL:
                              "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/feild%20measurment.png?alt=media&token=0e082754-86ee-4a22-b904-0f48747396af",
                          title: "Feild Measurment",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Quick Access Tools",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  HomeCardLargeWidget(
                    imageURL:
                        "https://firebasestorage.googleapis.com/v0/b/krishi-sahayak-190a1.appspot.com/o/agri%20marketplace.png?alt=media&token=f28a16e9-662f-42fe-bf35-431d823c59e0",
                    title: "Agri-Marketplace",
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

// ignore: must_be_immutable
class HomeCardWidget extends StatelessWidget {
  String title;
  String imageURL;
  HomeCardWidget({
    super.key,
    required this.imageURL,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

// ignore: must_be_immutable
class HomeCardLargeWidget extends StatelessWidget {
  String title;
  String imageURL;
  HomeCardLargeWidget({
    super.key,
    required this.imageURL,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
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
    );
  }
}
