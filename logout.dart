import 'package:flutter/material.dart';

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

void logout(BuildContext context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}
