








import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/CharacterData/data.dart';
import '../providers/chosen_class_Provider.dart';


@immutable
class Data extends StatelessWidget {
  const Data({super.key}
  );


// Filter data before passing to the chart
List<Map<String, Object>> getFilteredData(List<Map<String, dynamic>>? data) {
  if (data == null) return []; // Handle potential null data
  return data
      .where((map) => map['genre'] != null && map['sold'] != null)
      .map((map) => {
    'genre': map['genre'] as String,
    'sold': map['sold'] as num,
  })
      .toList();
}


List<Map<String, Object>>? MyFilter(BuildContext context) {
  var filteredData1 = classlistData;
  if (context
      .watch<ChosenClassProvider>()
      .selectedClass <= classlistData.length - 1) {
    var chosenClassData = context
        .watch<ChosenClassProvider>()
        .chosenClass;
    filteredData1 = getFilteredData(
        [chosenClassData]);
    var filteredData2 = getFilteredData(
        [chosenClassData]);
    return filteredData1;
  } else if (context
      .watch<ChosenClassProvider>()
      .selectedClass >= classlistData.length) {
    filteredData1 = classlistData;
    return filteredData1;
  }
  return null;
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MyFilter(context);
    throw UnimplementedError();
  }
}