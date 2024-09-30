import 'package:flutter/material.dart';
import 'app_data.dart';  // Assuming this is where classColors and getClassColor are defined

class ClassProvider with ChangeNotifier {
  // Classes are based on the keys from app_data.dart
  List<String> _classes = classColors.keys.toList();
  String _selectedClass = 'All Classes';  // Default selected class

  // Getters
  List<String> get classes => _classes;
  String get selectedClass => _selectedClass;

  // Method to update selected class
  void selectClass(String newClass) {
    _selectedClass = newClass;
    notifyListeners();  // Notify widgets listening to this provider
  }

  // Optionally: you could have a method that returns the color for the selected class
  Color getSelectedClassColor() {
    return getClassColor(_selectedClass);  // Assuming getClassColor is defined in app_data.dart
  }
}
