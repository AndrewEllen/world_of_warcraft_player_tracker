import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import 'package:wow_player_tracker/providers/chosenclassProvider.dart';
import 'CharacterData/data.dart';

import 'package:pretty_charts/pretty_charts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Timer timer;
  bool rebuild = false;

  // List of names to filter by
  //final List<String> namesToShow = ['DH', 'PAL'];

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
    var filteredData1 = classlistData;
    if(context.watch<ChosenClassProvider>().selectedClass <= classlistData.length -1) {
      var chosenClassData = context
          .watch<ChosenClassProvider>()
          .chosenClass;
     filteredData1 = getFilteredData(
          [if (chosenClassData != null) chosenClassData]);
      var filteredData2 = getFilteredData(
          [if (chosenClassData != null) chosenClassData]);
    }else if (context.watch<ChosenClassProvider>().selectedClass >= classlistData.length)
    {
      filteredData1 = classlistData;

    }


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

            //
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
              child: const Text(
                'Custom Legend',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              alignment: Alignment.centerLeft,
              child: const Text(
                '- Custom legend by mark and tag annotations.',
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              alignment: Alignment.centerLeft,
              child: const Text(
                '- With dodge modifier.',
              ),
            ),
            /*
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 350,
              height: 200,
              child: Chart(
                padding: (_) => const EdgeInsets.fromLTRB(40, 5, 10, 40),
                data: adjustData,
                variables: {
                  'index': Variable(
                    accessor: (Map map) => map['index'].toString(),
                  ),
                  'type': Variable(
                    accessor: (Map map) => map['type'] as String,
                  ),
                  'value': Variable(
                    accessor: (Map map) => map['value'] as num,
                  ),
                },
                marks: [
                  IntervalMark(
                    position:
                    Varset('index') * Varset('value') / Varset('type'),
                    color: ColorEncode(
                        variable: 'type', values: Defaults.colors10),
                    size: SizeEncode(value: 2),
                    modifiers: [DodgeModifier(ratio: 0.1)],
                  )
                ],
                coord: RectCoord(
                  horizontalRangeUpdater: Defaults.horizontalRangeEvent,
                ),
                axes: [
                  Defaults.horizontalAxis..tickLine = TickLine(),
                  Defaults.verticalAxis,
                ],
                selections: {
                  'tap': PointSelection(
                    variable: 'index',
                  )
                },
                tooltip: TooltipGuide(multiTuples: true),
                crosshair: CrosshairGuide(),
                annotations: [
                  CustomAnnotation(
                      renderer: (_, size) => [
                        CircleElement(
                            center: const Offset(25, 290),
                            radius: 5,
                            style: PaintStyle(
                                fillColor: Defaults.colors10[0]))
                      ],
                      anchor: (p0) => const Offset(0, 0)),
                  TagAnnotation(
                    label: Label(
                      'Email',
                      LabelStyle(
                          textStyle: Defaults.textStyle,
                          align: Alignment.centerRight),
                    ),
                    anchor: (size) => const Offset(34, 290),
                  ),
                  CustomAnnotation(
                      renderer: (_, size) => [
                        CircleElement(
                            center: Offset(25 + size.width / 5, 290),
                            radius: 5,
                            style: PaintStyle(
                                fillColor: Defaults.colors10[1]))
                      ],
                      anchor: (p0) => const Offset(0, 0)),
                  TagAnnotation(
                    label: Label(
                      'Affiliate',
                      LabelStyle(
                          textStyle: Defaults.textStyle,
                          align: Alignment.centerRight),
                    ),
                    anchor: (size) => Offset(34 + size.width / 5, 290),
                  ),
                  CustomAnnotation(
                      renderer: (_, size) => [
                        CircleElement(
                            center: Offset(25 + size.width / 5 * 2, 290),
                            radius: 5,
                            style: PaintStyle(
                                fillColor: Defaults.colors10[2]))
                      ],
                      anchor: (p0) => const Offset(0, 0)),
                  TagAnnotation(
                    label: Label(
                      'Video',
                      LabelStyle(
                          textStyle: Defaults.textStyle,
                          align: Alignment.centerRight),
                    ),
                    anchor: (size) => Offset(34 + size.width / 5 * 2, 290),
                  ),
                  CustomAnnotation(
                      renderer: (_, size) => [
                        CircleElement(
                            center: Offset(25 + size.width / 5 * 3, 290),
                            radius: 5,
                            style: PaintStyle(
                                fillColor: Defaults.colors10[3]))
                      ],
                      anchor: (p0) => const Offset(0, 0)),
                  TagAnnotation(
                    label: Label(
                      'Direct',
                      LabelStyle(
                          textStyle: Defaults.textStyle,
                          align: Alignment.centerRight),
                    ),
                    anchor: (size) => Offset(34 + size.width / 5 * 3, 290),
                  ),
                  CustomAnnotation(
                      renderer: (_, size) => [
                        CircleElement(
                            center: Offset(25 + size.width / 5 * 4, 290),
                            radius: 5,
                            style: PaintStyle(
                                fillColor: Defaults.colors10[4]))
                      ],
                      anchor: (p0) => const Offset(0, 0)),
                  TagAnnotation(
                    label: Label(
                      'Search',
                      LabelStyle(
                          textStyle: Defaults.textStyle,
                          align: Alignment.centerRight),
                    ),
                    anchor: (size) => Offset(34 + size.width / 5 * 4, 290),
                  ),
                ],
              ),
            ),
*/



          ],
        ),
      ),

      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ChosenClassProvider>().updateSelectedClass();
        },
        child: const Icon(Icons.add),
      ), */
    );
  }
}
