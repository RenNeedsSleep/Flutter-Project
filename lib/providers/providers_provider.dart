import 'package:flutter/foundation.dart';

import '../data/dummy_providers.dart';
import '../models/service_provider.dart';

class ProvidersProvider extends ChangeNotifier {
  String searchText = '';
  String selectedCategory = 'All';

  List<ServiceProvider> get filteredProviders {
    final query = searchText.trim().toLowerCase();
    final result = dummyProviders.where((provider) {
      final matchesCategory = selectedCategory == 'All' ||
          provider.category == selectedCategory;
      final matchesSearch = query.isEmpty ||
          provider.name.toLowerCase().contains(query) ||
          provider.city.toLowerCase().contains(query) ||
          provider.category.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();

    return result;
  }

  void setSearch(String value) {
    searchText = value;
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }
}
