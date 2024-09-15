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

import 'Compentents/actionbutton.dart';
import 'Compentents/expandablefab.dart';
import 'Compentents/statemanageController.dart';
import 'Components/expandingactionbutton.dart';
import 'constants.dart';


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
          ChangeNotifierProvider(create: (context) => StateManageController()),
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
class _MyHomePageState extends State<MyHomePage>{
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

appBar: AppBar(
  title: const Text("WoW Guild App"),
),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guild Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Manage your guild data',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Raid Progress'),
              onTap: () {
                // Navigate to Raid Progress page
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Guild Roster'),
              onTap: () {
                // Navigate to Guild Roster page
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Mythic Progress'),
              onTap: () {
                // Navigate to Mythic Progress page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings page
              },
            ),
          ],
        ),
      ),



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
              context.read<StateManageController>().setOpenState();

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
              context.read<StateManageController>().setOpenState();
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




