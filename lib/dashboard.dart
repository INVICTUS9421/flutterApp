import 'package:flutter/material.dart';
import 'package:project/appointment.dart';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2, // Number of cards in a row
          childAspectRatio: 1.0, // Keep cards square
          mainAxisSpacing: 20.0, // Adjust spacing between rows
          crossAxisSpacing: 20.0, // Adjust spacing between columns
          children: <Widget>[
            DashboardCard('Patients', Icons.person, Colors.green),
            DashboardCard('Appointments', Icons.calendar_today, Colors.blue),
            DashboardCard('Medications', Icons.medication, Colors.orange),
            DashboardCard('Reports', Icons.description, Colors.red),
            DashboardCard('Settings', Icons.settings, Colors.grey),
            DashboardCard('Notifications', Icons.notifications, Colors.purple),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardCard(this.title, this.icon, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          if (title == 'Appointments') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddAppointmentScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Loading $title'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 40.0, color: Colors.white),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}