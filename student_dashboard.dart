import 'package:flutter/material.dart';
import '../main.dart'; // ✅ IMPORT YOUR LOGIN PAGE (LoginPage is in main.dart)
import 'block_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  // 🔴 CONFIRM LOGOUT
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

  // 🔴 FINAL LOGOUT (go to LoginPage)
  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  void openBlocks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlockScreen(action: "view")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),

      appBar: AppBar(
        title: const Text("BMSCE - Student Dashboard"),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () => confirmLogout(context),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Welcome, Student",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () => openBlocks(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(250, 50),
                  ),
                  child: const Text("View Empty Classrooms"),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10),
        child: const Text(
          "© 2025 BMS College of Engineering",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
