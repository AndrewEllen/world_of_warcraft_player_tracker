import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/class_provider.dart';

class GuildRosterPage extends StatefulWidget {
  const GuildRosterPage({Key? key}) : super(key: key);

  @override
  _GuildRosterPageState createState() => _GuildRosterPageState();
}

class _GuildRosterPageState extends State<GuildRosterPage> {
  @override
  Widget build(BuildContext context) {
    // Access the ClassProvider
    final classProvider = Provider.of<ClassProvider>(context);

    // Ensure 'All Classes' is always part of the class list and it's not duplicated
    if (!classProvider.classes.contains('All Classes')) {
      classProvider.classes.insert(0, 'All Classes');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guild Roster'),
        backgroundColor: classProvider.getSelectedClassColor(),  // Example use of class color
      ),
      body: Column(
        children: [
          // Class Selection Dropdown
          DropdownButton<String>(
            value: classProvider.selectedClass,  // Currently selected class
            items: classProvider.classes.map((String className) {
              return DropdownMenuItem<String>(
                value: className,
                child: Text(className),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                // Update the selected class using provider
                classProvider.selectClass(newValue);
              }
            },
          ),
          // Your guild roster or other UI elements
          Expanded(
            child: ListView.builder(
              itemCount: classProvider.classes.length,  // Example: Using class list size for now
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(classProvider.classes[index]),  // Just an example list of classes
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
