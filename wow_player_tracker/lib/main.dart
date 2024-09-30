import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_player_tracker/pages/blank_template.dart';
import 'package:wow_player_tracker/pages/first_page.dart';
import 'package:wow_player_tracker/pages/guild_roster_page.dart';
import 'package:wow_player_tracker/pages/second_page.dart';
import 'package:wow_player_tracker/pages/test_page.dart';
import 'package:wow_player_tracker/providers/chosen_class_Provider.dart';
import 'package:wow_player_tracker/providers/class_provider.dart';
import 'package:wow_player_tracker/providers/counter_Provider.dart';

import 'Compentents/action_button.dart';
import 'Compentents/expandablefab.dart';
import 'Compentents/state_manage_Controller.dart';

//consistent variables
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
        ChangeNotifierProvider(create: (context) => ClassProvider())
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
      title: 'WoW Guild App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'WoW Guild App Home'),
    );
  }
}

//home page title state
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//the State Manager
class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;
  int _selectedIndex = 0;

  List<Widget> pages = [
    const FirstPage(),
    const SecondPage(),
    const Testpage(),
    const BlankTemplate(),
    GuildRosterPage(),
  ];

  // Navigation Builder
  @override
  Widget build(BuildContext context) {
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
              leading: const Icon(Icons.dashboard),
              title: const Text('Raid Progress'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 1; // Navigate to SecondPage
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Guild Roster'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 4; // Navigate to GuildRosterPage
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Mythic Progress'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 2; // Navigate to Testpage
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 3; // Navigate to BlankTemplate
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 150,
        children: [
          // Your ActionButtons here...
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Raid Progress",
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Mythic Progress",
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Guild Roster",
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: pages[_selectedIndex],
    );
  }
}
