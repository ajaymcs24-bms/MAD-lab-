import 'package:flutter/material.dart';
import 'classroom_screen.dart';
import 'auditorium_screen.dart';

class BlockScreen extends StatelessWidget {
  final String action; // "take" or "view"

  // ❌ removed const (fix error)
  BlockScreen({super.key, required this.action});

  // you can also make this const list (optional)
  final List<String> blocks = [
    "PG Block",
    "APS Block",
    "Science Block",
    "Mechanical Block",
    "PJ Block",
  ];

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

  // 👉 open classroom
  void openBlock(BuildContext context, String block) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClassroomScreen(block: block, action: action),
      ),
    );
  }

  // 👉 open auditorium
  void openAuditorium(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuditoriumScreen(action: action)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),

      // 🔵 APPBAR
      appBar: AppBar(
        title: const Text("Select Block"),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () => confirmLogout(context),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              "Select a Block",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // 🔲 BLOCK GRID
            Expanded(
              child: GridView.builder(
                itemCount: blocks.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) {
                  if (index < blocks.length) {
                    return _blockCard(
                      context,
                      blocks[index],
                      () => openBlock(context, blocks[index]),
                    );
                  } else {
                    return _blockCard(
                      context,
                      "Auditorium",
                      () => openAuditorium(context),
                    );
                  }
                },
              ),
            ),

            // 🔙 BACK BUTTON
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("⬅ Back"),
            ),
          ],
        ),
      ),
    );
  }

  // 🎴 BLOCK CARD
  Widget _blockCard(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
