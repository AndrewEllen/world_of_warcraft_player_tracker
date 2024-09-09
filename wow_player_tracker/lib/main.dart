import 'dart:async';
import 'dart:ffi';
import 'dart:math' as math;


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_player_tracker/pages/CharacterData/data.dart';
import 'package:wow_player_tracker/pages/blanktemplate.dart';
import 'package:wow_player_tracker/pages/firstpage.dart';
import 'package:wow_player_tracker/pages/secondpage.dart';
import 'package:wow_player_tracker/pages/testpage.dart';
import 'package:wow_player_tracker/providers/chosenclassProvider.dart';

import 'package:wow_player_tracker/providers/counterProvider.dart';



//consistent veriables
const int classSelected = 0;

late Timer timer;

bool rebuild = false;




//the main app starter
void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChosenClassProvider()),
          ChangeNotifierProvider(create: (context) => CounterProvider()),

        ],
      child: const MyApp(),

    ),
  );
}




//the base app start up app method
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


//home page title state
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//the State Manager
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
  List<Widget> pages = [

    FirstPage(),
    SecondPage(),
    Testpage(),
    BlankTemplate(),
  ];


  // Navigation Builder
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      floatingActionButton: ExpandableFab(
        distance: 150,
        children: [
          ActionButton(
            //Warrior
            onPressed: () {

              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(0);

            },
            icon: Image.asset('WCIcons/Class_Warrior_Icon.png'),
          ),
          ActionButton(
            //Paladin

            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true

              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(1);

            },
            icon: Image.asset('WCIcons/Class_Paladin_Icon.png'),
          ),
          ActionButton(
            //Hunter
            onPressed: () {

              setState(() {
                rebuild = true; // Set the rebuild flag to true

              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(2);
            },
            icon: Image.asset('WCIcons/Class_Hunter_Icon.png'),
          ),
          ActionButton(
            //Rogue
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(3);
            },
            icon: Image.asset('WCIcons/Class_Rogue_Icon.png'),
          ),

          ActionButton(
            //Priest
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(4);
            },
            icon: Image.asset('WCIcons/Class_Priest_Icon.png'),
          ),
          ActionButton(
            //Shaman
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(5);
            },
            icon: Image.asset('WCIcons/Class_Shaman_Icon.png'),
          ),
          ActionButton(
            //Warlock
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(6);
            },
            icon: Image.asset('WCIcons/Class_Warlock_Icon.png'),
          ),
          ActionButton(
            //Monk
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(7);
            },
            icon: Image.asset('WCIcons/Class_monk_Icon.png'),
          ),
          ActionButton(
            //Druid
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(8);
            },
            icon: Image.asset('WCIcons/Class_Druid_Icon.png'),
          ),
          ActionButton(
            //Demon Hunter
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(9);
            },
            icon: Image.asset('WCIcons/Class_Demon_Hunter_Icon.png'),
          ),
          ActionButton(
            //Death Knight
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(10);
            },
            icon: Image.asset('WCIcons/Class-Death-Knight-Icon.png'),
          ),
          ActionButton(
            //Evoker
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(11);
            },
            icon: Image.asset('WCIcons/Class_Evoker_Icon.png'),
          ),
          ActionButton(
            onPressed: () {
              setState(() {
                rebuild = true; // Set the rebuild flag to true
              });
              // Optionally, update the selected class using the provider
              context.read<ChosenClassProvider>().updateSelectedClass(12);
            },
            icon: Image.asset('WCIcons/Class_All_Icon.png'),

          ),
        ],
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.red,
            ),BottomNavigationBarItem(
                icon: Icon(Icons.local_post_office),
              label: "Second",
              backgroundColor: Colors.green,
            ),BottomNavigationBarItem(
                icon: Icon(Icons.local_post_office),
              label: "Test",
              backgroundColor: Colors.cyan,
            ),BottomNavigationBarItem(
                icon: Icon(Icons.local_post_office),
              label: "Test2",
              backgroundColor: Colors.purple,
            ),

          ],



        currentIndex: _selectedIndex,
        onTap: (index) => {

            setState(() {
              _selectedIndex = index;
            })

        },
      ),
      body: pages[_selectedIndex],
    );
  }
}

//Class Button Starter
@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

//Opening button maker
class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        //aligment controles where it is
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
         _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }


  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }


  //this handles the little bittons
  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 140.0 / (count);
    for (var i = 0, angleInDegrees =1.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.bottomCenter,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

//Child Class button maker
@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 2.0),
          progress.value * maxDistance,

        );
        return Positioned(
          right: 175.0 + offset.dx,
          bottom: 450 + offset.dy,
          child: Row(
            children: [child!],
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}



//This is where i can add little details
//action button are the Class buttons
@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon : icon,
        color: Colors.transparent,
      ),
    );
  }
}