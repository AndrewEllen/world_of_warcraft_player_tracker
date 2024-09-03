import 'package:flutter/cupertino.dart';
import 'package:wow_player_tracker/pages/CharacterData/data.dart';

class ChosenClassProvider with ChangeNotifier {
  int _selectedClass = 0;
  int _maxClasses = classlistData.length - 1; // Adjust based on actual data length

  int get selectedClass => _selectedClass;
  Map<String, dynamic> get chosenClass => classlistData[_selectedClass];

  void updateSelectedClass() {
    if (_selectedClass >= _maxClasses) {
      _selectedClass = 0;
    } else {
      _selectedClass++;
    }
    notifyListeners();
  }
}