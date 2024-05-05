import 'package:krishi_sahayak/providers/auth_service_provider.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> multiProviders = [
  ChangeNotifierProvider<AuthServiceProvier>(
      create: (context) => AuthServiceProvier()),
  ChangeNotifierProvider<FeedProvider>(create: (context) => FeedProvider()),
];
