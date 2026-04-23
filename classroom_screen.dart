import 'dart:async';
import 'package:flutter/material.dart';

class ClassroomScreen extends StatefulWidget {
  final String block;
  final String action; // "take" or "view"

  const ClassroomScreen({super.key, required this.block, required this.action});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  String currentUser = "faculty@bmsce.ac.in";
  String? activeRoom;

  Map<String, List<Map<String, dynamic>>> rooms = {
    "Floor 1": [
      {"room": "101", "status": "empty"},
      {"room": "102", "status": "empty"},
      {"room": "103", "status": "empty"},
      {"room": "104", "status": "empty"},
      {"room": "105", "status": "empty"},
    ],
    "Floor 2": [
      {"room": "201", "status": "empty"},
      {"room": "202", "status": "empty"},
      {"room": "203", "status": "empty"},
      {"room": "204", "status": "empty"},
      {"room": "205", "status": "empty"},
    ],
  };

  // 🔴 LOGOUT FUNCTIONS
  void confirmLogout() {
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
              logout();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  void logout() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // ROOM CLICK
  void handleTap(String floor, int index) {
    var room = rooms[floor]![index];

    if (widget.action == "view") {
      showMsg("Room ${room["room"]} is ${room["status"]}");
      return;
    }

    if (activeRoom != null &&
        room["status"] == "empty" &&
        room["markedBy"] != currentUser) {
      showMsg("You already have an active class!");
      return;
    }

    if (room["status"] == "occupied" && room["markedBy"] != currentUser) {
      showMsg("Already taken by another faculty!");
      return;
    }

    setState(() {
      if (room["status"] == "empty") {
        room["status"] = "occupied";
        room["markedBy"] = currentUser;
        room["endTime"] = DateTime.now().millisecondsSinceEpoch + 5 * 60 * 1000;

        activeRoom = room["room"];
      } else {
        room["status"] = "empty";
        room.remove("markedBy");
        room.remove("endTime");
        activeRoom = null;
      }
    });
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Color getColor(String status) {
    return status == "empty" ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),

      // 🔵 APPBAR WITH LOGOUT
      appBar: AppBar(
        title: Text(widget.block),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: confirmLogout,
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: rooms.keys.map((floor) {
            return Column(
              children: [
                const SizedBox(height: 20),

                Text(
                  floor,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rooms[floor]!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    var room = rooms[floor]![index];

                    return GestureDetector(
                      onTap: () => handleTap(floor, index),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: getColor(room["status"]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    room["room"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (room["markedBy"] != null)
                                    const Text(
                                      "Me",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          // ⏱ TIMER
                          if (room["status"] == "occupied" &&
                              room["endTime"] != null)
                            Positioned(
                              top: 5,
                              right: 5,
                              child: TimerWidget(
                                endTime: room["endTime"],
                                onExpire: () {
                                  setState(() {
                                    room["status"] = "empty";
                                    room.remove("markedBy");
                                    room.remove("endTime");
                                    activeRoom = null;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ⏱ TIMER WIDGET
class TimerWidget extends StatefulWidget {
  final int endTime;
  final VoidCallback onExpire;

  const TimerWidget({super.key, required this.endTime, required this.onExpire});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer timer;
  int remaining = 0;

  @override
  void initState() {
    super.initState();
    update();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => update());
  }

  void update() {
    int left = widget.endTime - DateTime.now().millisecondsSinceEpoch;

    if (left <= 0) {
      timer.cancel();
      widget.onExpire();
    } else {
      setState(() {
        remaining = left;
      });
    }
  }

  String format() {
    int m = remaining ~/ 60000;
    int s = (remaining % 60000) ~/ 1000;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        format(),
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
