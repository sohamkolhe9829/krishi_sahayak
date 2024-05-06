import 'package:krishi_sahayak/providers/admin_provider.dart';
import 'package:krishi_sahayak/providers/auth_service_provider.dart';
import 'package:krishi_sahayak/providers/feed_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/feild_measurment_provider.dart';

List<SingleChildWidget> multiProviders = [
  ChangeNotifierProvider<AuthServiceProvier>(
      create: (context) => AuthServiceProvier()),
  ChangeNotifierProvider<FeedProvider>(create: (context) => FeedProvider()),
  ChangeNotifierProvider<AdminProvider>(create: (context) => AdminProvider()),
  ChangeNotifierProvider<FeildMeasurmentProvider>(
      create: (context) => FeildMeasurmentProvider()),
];
