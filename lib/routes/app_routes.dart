import 'package:flutter/material.dart';

import '../screens/details_screen.dart';
import '../screens/home_screen.dart';
import '../screens/request_form_screen.dart';
import '../screens/review_screen.dart';
import '../screens/schedule_screen.dart';
import '../screens/success_screen.dart';
import '../screens/welcome_screen.dart';
import '../models/service_provider.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String details = '/details';
  static const String request = '/request';
  static const String schedule = '/schedule';
  static const String review = '/review';
  static const String success = '/success';

  static Map<String, WidgetBuilder> get routes => {
        welcome: (_) => const WelcomeScreen(),
        home: (_) => const HomeScreen(),
        details: (context) {
          final provider = ModalRoute.of(context)!.settings.arguments as ServiceProvider?;
          return DetailsScreen(provider: provider ?? const ServiceProvider(
            id: 'placeholder',
            name: 'Unknown',
            city: 'N/A',
            category: 'Cleaning',
            rating: 0,
            reviews: 0,
            pricePerHour: 0,
            verified: false,
            about: 'No provider details available.',
          ));
        },
        request: (_) => const RequestFormScreen(),
        schedule: (_) => const ScheduleScreen(),
        review: (_) => const ReviewScreen(),
        success: (_) => const SuccessScreen(),
      };
}
