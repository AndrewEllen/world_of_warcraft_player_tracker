import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import 'package:wow_player_tracker/providers/chosenclassProvider.dart';
import 'CharacterData/data.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Timer timer;
  bool rebuild = false;

  // List of names to filter by
  final List<String> namesToShow = ['DH', 'PAL'];

  // Filter data before passing to the chart
  List<Map<String, Object>> getFilteredData(List<Map<String, dynamic>>? data) {
    if (data == null) return []; // Handle potential null data
    return data
        .where((map) => map['genre'] != null && map['sold'] != null)
        .where((map) => namesToShow.contains(map['genre']))
        .map((map) => {
      'genre': map['genre'] as String,
      'sold': map['sold'] as num,
    })
        .toList();
  }

  @override
  void initState() {
    super.initState();
    // Set up periodic timer to update the data and trigger rebuilds
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        rebuild = !rebuild;
        // Example transformation of scatterAnimData
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use ChosenClassProvider safely, ensuring it doesn't return null
    final chosenClassData = context.watch<ChosenClassProvider>().chosenClass;
    final filteredData1 = getFilteredData([if (chosenClassData != null) chosenClassData]);
    final filteredData2 = getFilteredData([if (chosenClassData != null) chosenClassData]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("First Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Graphic 1
            Container(
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
            ),
            // Graphic 2
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
              child: Text(
                context.watch<ChosenClassProvider>().selectedClass.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Text(""),
            // Graphic 3 (if needed)
            /*
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 300,
              height: 300,
              child: Chart(
                data: filteredData2, // Use filtered data here
                variables: {
                  'genre': Variable(
                    accessor: (Map<String, Object> map) => map['genre'] as String,
                  ),
                  'sold': Variable(
                    accessor: (Map<String, Object> map) => map['sold'] as num,
                    scale: LinearScale(min: 0, marginMax: 0.1),
                  ),
                },
                marks: [
                  IntervalMark(
                    label: LabelEncode(
                        encoder: (tuple) => Label(tuple['genre'].toString())),
                    shape: ShapeEncode(
                        value: RectShape(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                        )),
                    color: ColorEncode(
                        variable: 'genre', values: Defaults.colors10),
                    elevation: ElevationEncode(value: 5),
                    transition: Transition(
                        duration: const Duration(seconds: 2),
                        curve: Curves.elasticOut),
                    entrance: {MarkEntrance.y},
                  )
                ],
                coord: PolarCoord(startRadius: 0.15),
              ),
            ),
            */
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ChosenClassProvider>().updateSelectedClass();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
