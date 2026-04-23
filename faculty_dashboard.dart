import 'package:flutter/material.dart';
import 'block_screen.dart';

class FacultyDashboard extends StatelessWidget {
  const FacultyDashboard({super.key});

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

  // 🔴 LOGOUT FUNCTION
  void logout(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void openBlocks(BuildContext context, String action) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlockScreen(action: action)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),

      appBar: AppBar(
        title: const Text("BMSCE - Faculty Dashboard"),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () => confirmLogout(context), // ✅ FIXED
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Welcome, Faculty",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () => openBlocks(context, "take"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(250, 50),
                ),
                child: const Text("Take / Mark Class"),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () => openBlocks(context, "view"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(250, 50),
                ),
                child: const Text("View Empty Classrooms"),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Report download (later backend)"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(250, 50),
                ),
                child: const Text("Download Class Report"),
              ),
            ],
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
