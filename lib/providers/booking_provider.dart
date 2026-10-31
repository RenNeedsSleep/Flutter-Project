import 'package:flutter/foundation.dart';

import '../models/booking_details.dart';
import '../models/service_provider.dart';

class BookingProvider extends ChangeNotifier {
  ServiceProvider? provider;
  BookingDetails? details;
  DateTime? selectedDate;
  String? selectedTime;

  void setProvider(ServiceProvider value) {
    provider = value;
    notifyListeners();
  }

  void setDetails(BookingDetails value) {
    details = value;
    notifyListeners();
  }

  void setSchedule(DateTime date, String time) {
    selectedDate = date;
    selectedTime = time;
    notifyListeners();
  }

  void clear() {
    provider = null;
    details = null;
    selectedDate = null;
    selectedTime = null;
    notifyListeners();
  }
}
