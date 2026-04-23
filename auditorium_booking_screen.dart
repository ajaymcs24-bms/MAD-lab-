import 'package:flutter/material.dart';

class AudiBookingScreen extends StatelessWidget {
  final String audi;

  const AudiBookingScreen({super.key, required this.audi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),

      appBar: AppBar(
        title: Text("$audi Booking"),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("⬅ Back"),
          ),

          const SizedBox(height: 20),

          Text(
            "Booking for $audi",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // 🔲 DUMMY SLOTS
          Expanded(
            child: ListView(
              children: [
                _slot("09:00 - 10:00", false),
                _slot("10:00 - 11:00", true),
                _slot("11:00 - 12:00", false),
                _slot("01:00 - 02:00", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _slot(String time, bool booked) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: booked ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        booked ? "$time (Booked)" : time,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
