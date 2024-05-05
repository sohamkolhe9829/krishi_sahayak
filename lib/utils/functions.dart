import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchFeedURL(LinkableElement url) async {
  // if (await launchUrl(Uri.parse(url))) {
  //   throw Exception('Could not launch $url');
  // }
  await launchUrl(
    Uri.parse(url.url),
    mode: LaunchMode.inAppBrowserView,
  );
}

String formatDate(DateTime dateTime) {
  final formatter = DateFormat('dd-MM-yyyy'); // Customize format as needed

  return formatter.format(dateTime);
}

String formatTime(DateTime dateTime) {
  final formatter = DateFormat('hh:mm a'); // Customize format as needed

  return formatter.format(dateTime);
}

String timeAgo(DateTime givenTime) {
  final now = DateTime.now();
  final difference = now.difference(givenTime);

  if (difference.inDays >= 1) {
    // After 24 hours, use hh:mm a format
    return DateFormat('hh:mm a').format(givenTime);
  } else if (difference.inHours >= 1) {
    return '${difference.inHours}hr ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}

showLoadingWidget(context) {
  showDialog(
    context: context,
    builder: (context) => CustomCircularLoading(),
  );
}
