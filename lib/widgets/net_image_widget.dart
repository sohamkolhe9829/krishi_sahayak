import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';

// ignore: must_be_immutable
class NetImageWidget extends StatelessWidget {
  String imageURL;
  NetImageWidget({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CustomCircularLoading(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
