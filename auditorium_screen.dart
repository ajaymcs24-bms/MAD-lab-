import 'package:flutter/material.dart';
import 'audi_booking_screen.dart'; // ✅ IMPORTANT

class AuditoriumScreen extends StatelessWidget {
  final String action; // "take" or "view"

  const AuditoriumScreen({super.key, required this.action});

  // 🔴 LOGOUT CONFIRM
  void confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logout(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  // 🔴 LOGOUT
  void logout(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void openAudi(BuildContext context, String audi) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AudiBookingScreen(audi: audi)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),

      appBar: AppBar(
        title: const Text("BMSCE - Auditorium"),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () => confirmLogout(context),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("⬅ Back to Blocks"),
          ),

          const SizedBox(height: 20),

          const Text(
            "Select Auditorium",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _audiCard(context, "Audi 1"),
              const SizedBox(width: 20),
              _audiCard(context, "Audi 2"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _audiCard(BuildContext context, String title) {
    return GestureDetector(
      onTap: () => openAudi(context, title),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
