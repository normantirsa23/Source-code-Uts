import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReminderScreen(),
    );
  }
}

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, String>> reminders = [];

  void addReminder(String title, String note) {
    setState(() {
      reminders.add({"title": title, "note": note});
    });
  }

  void editReminder(int index, String title, String note) {
    setState(() {
      reminders[index] = {"title": title, "note": note};
    });
  }

  void deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
  }

  void showAddReminderDialog() {
    String title = '';
    String note = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Reminder Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (text) => title = text,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (text) => note = text,
                decoration: InputDecoration(labelText: 'Note'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                if (title.isNotEmpty) {
                  addReminder(title, note);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showEditReminderDialog(int index, String title, String note) {
    String newTitle = title;
    String newNote = note;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Reminder Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (text) => newTitle = text,
                controller: TextEditingController(text: newTitle),
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (text) => newNote = text,
                controller: TextEditingController(text: newNote),
                decoration: InputDecoration(labelText: 'Note'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
                editReminder(index, newTitle, newNote);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder App'),
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(reminders[index]["title"]!),
            subtitle: Text(reminders[index]["note"]!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => showEditReminderDialog(
                      index, reminders[index]["title"]!, reminders[index]["note"]!),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteReminder(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddReminderDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
