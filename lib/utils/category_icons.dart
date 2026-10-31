import 'package:flutter/material.dart';

IconData categoryIcon(String category) {
  switch (category) {
    case 'All':
      return Icons.apps;
    case 'Cleaning':
      return Icons.cleaning_services;
    case 'Landscaping':
      return Icons.yard;
    case 'Electrical':
      return Icons.electrical_services;
    case 'Plumbing':
      return Icons.plumbing;
    default:
      return Icons.handyman;
  }
}
