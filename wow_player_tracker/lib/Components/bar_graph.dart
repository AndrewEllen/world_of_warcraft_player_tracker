import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../pages/CharacterData/data.dart';
import '../providers/chosen_class_Provider.dart';

@immutable
class BarGraph extends StatelessWidget {
  const BarGraph({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;


  Future<List<Map<String, Object>>> filter(dynamic context)
  async {
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

    var filteredData1 = classlistData;
    if (context
        .watch<ChosenClassProvider>()
        .selectedClass <= classlistData.length - 1) {
      var chosenClassData = context
          .watch<ChosenClassProvider>()
          .chosenClass;
      filteredData1 = getFilteredData(
          [if (chosenClassData != null) chosenClassData]);
      var filteredData2 = getFilteredData(
          [if (chosenClassData != null) chosenClassData]);
    } else if (context
        .watch<ChosenClassProvider>()
        .selectedClass >= classlistData.length) {
      filteredData1 = classlistData;
      return filteredData1;
    }
  }

  }



  @override
  Widget build(BuildContext context) {
      return Container(
    margin: const EdgeInsets.only(top: 10),
    width: 400,
    height: 300,
    child: Chart(
    data: filter(context), // Use filtered data here
    variables: {
    'genre': Variable(
    accessor: (Map<String, Object> map) => map['genre'] as String,
    ),
    'sold': Variable(
    accessor: (Map<String, Object> map) => map['sold'] as num,
    ),
    },
    marks: [
    IntervalMark(
    label: LabelEncode(
    encoder: (tuple) => Label(tuple['sold'].toString())),
    elevation: ElevationEncode(value: 0, updaters: {
    'tap': {true: (_) => 75} // Color Bleed from bar
    }),
    color: ColorEncode(value: Defaults.primaryColor, updaters: {
    'tap': {false: (color) => color.withAlpha(100)} // On tap changes other bars
    }),
    )
    ],
    axes: [
    Defaults.horizontalAxis,
    Defaults.verticalAxis,
    ],
    selections: {'tap': PointSelection(dim: Dim.x)},
    tooltip: TooltipGuide(),
    crosshair: CrosshairGuide(),
    ),
    );
  }
}




/*
 margin: const EdgeInsets.only(top: 10),
              width: 400,
              height: 300,
              child: Chart(
                data: filteredData1, // Use filtered data here
                variables: {
                  'genre': Variable(
                    accessor: (Map<String, Object> map) => map['genre'] as String,
                  ),
                  'sold': Variable(
                    accessor: (Map<String, Object> map) => map['sold'] as num,
                  ),
                },
                marks: [
                  IntervalMark(
                    label: LabelEncode(
                        encoder: (tuple) => Label(tuple['sold'].toString())),
                    elevation: ElevationEncode(value: 0, updaters: {
                      'tap': {true: (_) => 75} // Color Bleed from bar
                    }),
                    color: ColorEncode(value: Defaults.primaryColor, updaters: {
                      'tap': {false: (color) => color.withAlpha(100)} // On tap changes other bars
                    }),
                  )
                ],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
                selections: {'tap': PointSelection(dim: Dim.x)},
                tooltip: TooltipGuide(),
                crosshair: CrosshairGuide(),
              ),

 */