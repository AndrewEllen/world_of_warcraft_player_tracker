import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_player_tracker/providers/counterProvider.dart';
import 'package:graphic/graphic.dart';


import 'CharacterData/data.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {


  //Main method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("Scrolling"),
      ),
      body: _scroll(context),
    );
  }

  final List<String> entries = <String>['A', 'B', 'C', 'B', 'C'];
  final List<int> colorCodes = <int>[50, 100, 200, 300, 400, 500];


  /*scrollable area method
  Widget _scroll(BuildContext Context){
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Entry ${entries[index]}')),
    );
    }
  );
}
*/
  Widget _scroll(BuildContext Context) {
    return Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
                        child: const Text(
                          'Transposed Bar Chart',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),

                      TextButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                if (states.contains(WidgetState.hovered)) {
                                  return Colors.blue.withOpacity(0.04);
                                }
                                if (states.contains(WidgetState.focused) ||
                                    states.contains(WidgetState.pressed)) {
                                  return Colors.blue.withOpacity(0.12);
                                }
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                          onPressed: () { },
                          child: const Text('TextButton')
                      )






                    ],
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}