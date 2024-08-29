import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import 'CharacterData/data.dart';


class Testpage extends StatefulWidget {
  const Testpage({super.key});

  @override
  State<Testpage> createState() => _testpageState();
}

class _testpageState extends State<Testpage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      /* This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.*/
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /* This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.*/
    return Scaffold(
      appBar: AppBar(
        /* TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.*/
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("First Page"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          /* Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.*/
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
              child: const Text(
                'Classes',
                style: TextStyle(fontSize: 40),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 500,
              height: 500,
              child: Chart(
                data: basicData,
                variables: {
                  'genre': Variable(
                    accessor: (Map map) => map['genre'] as String,
                  ),
                  'sold': Variable(
                    accessor: (Map map) => map['sold'] as num,
                  ),
                },
                marks: [
                  IntervalMark(
                    label: LabelEncode(
                      encoder: (tuple) => Label(
                        tuple['sold'].toString(),
                        LabelStyle(
                          textStyle: TextStyle(
                            fontSize: 20,  // Increase font size here
                            color: Colors.black,  // Optional: Adjust text color
                          ),
                          offset: const Offset(
                              0,
                              0
                          ),
                        ),
                      ),
                    ),
                    gradient: GradientEncode(
                      value: const LinearGradient(
                        colors: [
                          Color(0x8883bff6),
                          Color(0x88188df0),
                          Color(0xcc1f00ac),
                        ],
                        stops: [0, 0.5, 1],
                      ),
                      updaters: {
                        'tap': {
                          true: (_) => const LinearGradient(
                            colors: [
                              Color(0xee83bff6),
                              Color(0xee3f78f7),
                              Color(0xffac0071),
                            ],
                            stops: [0, 0.7, 1],
                          ),
                        },
                      },
                    ),
                  ),
                ],
                coord: RectCoord(transposed: true),
                axes: [
                  Defaults.verticalAxis
                    ..line = Defaults.strokeStyle
                    ..grid = null
                    ..label = LabelStyle(
                      textStyle: const TextStyle(
                        fontSize: 15,  // Adjust the font size for vertical axis labels
                        color: Colors.black,  // Optional: Adjust text color
                      ),
                        offset: const Offset(
                            -10,
                            0
                        )
                    ),
                  Defaults.horizontalAxis
                    ..line = null
                    ..grid = Defaults.strokeStyle
                    ..label = LabelStyle(
                      textStyle: const TextStyle(
                        fontSize: 14,  // Adjust the font size for horizontal axis labels
                        color: Colors.black,  // Optional: Adjust text color
                      ),
                      offset: const Offset(
                          0,
                          0
                      )
                    ),
                ],
                selections: {'tap': PointSelection(dim: Dim.x)},
              ),
            ),

          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
