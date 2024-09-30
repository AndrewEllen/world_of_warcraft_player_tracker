import 'package:flutter/material.dart';

// Define the class colors for World of Warcraft
Map<String, Color> classColors = {
  'Warrior': Color(0xFFC79C6E),
  'Paladin': Color(0xFFF58CBA),
  'Hunter': Color(0xFFABD473),
  'Rogue': Color(0xFFFFF569),
  'Priest': Color(0xFFFFFFFF),
  'Death Knight': Color(0xFFC41F3B),
  'Shaman': Color(0xFF0070DE),
  'Mage': Color(0xFF69CCF0),
  'Warlock': Color(0xFF9482C9),
  'Monk': Color(0xFF00FF96),
  'Druid': Color(0xFFFF7D0A),
  'Demon Hunter': Color(0xFFA330C9),
};

// Method to get class color
Color getClassColor(String className) {
  return classColors[className] ?? Colors.grey; // Return grey if class not found
}

// Other persistent data or utility functions can be added here

