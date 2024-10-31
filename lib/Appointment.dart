import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the home screen of the app
      home: Directionality(
        textDirection: TextDirection.ltr, // Set the text direction
        child: AddAppointmentScreen(), // Your main app content
      ),
    );
  }
}

class appointment {
  final String title;
  final DateTime dateTime;

  appointment({required this.title, required this.dateTime});
}

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  _AddAppointmentScreenState createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final _titleController = TextEditingController();
  DateTime? _selectedDateTime;

  void _pickDateTime(BuildContext context) async {
    // Show date picker dialog
    final pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      // Show time picker dialog
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickedDateTime),
      );

      if (pickedTime != null) {
        // Combine selected date and time
        setState(() {
          _selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveAppointment() {
    // Check if title and date/time are provided
    if (_titleController.text.isNotEmpty && _selectedDateTime != null) {
      // Create a new Appointment object
      final newAppointment = appointment(
        title: _titleController.text,
        dateTime: _selectedDateTime!,
      );

      // Go back to the previous screen with the new appointment
      Navigator.pop(context, newAppointment);
    } else {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Appointment'),
      ),
      body: Center(
        child: SizedBox(
          width: 300, // Set your desired width here
          child: Card(
            elevation: 4, // Adds a shadow effect to the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Minimize the height of the card
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Appointment Title'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _selectedDateTime == null
                        ? 'No date/time chosen!'
                        : 'Picked Date/Time: ${_selectedDateTime.toString()}',
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _pickDateTime(context),
                    child: Text('Choose Date & Time'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveAppointment,
                    child: Text('Save Appointment'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
