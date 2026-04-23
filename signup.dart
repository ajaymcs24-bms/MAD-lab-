import 'package:flutter/material.dart';
import '../utils/user_store.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String role = "";

  void signup() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || role.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    UserStore.users.add({
      "name": name,
      "email": email,
      "password": password,
      "role": role,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Signup successful! Please login")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),

      body: Column(
        children: [
          // 🔵 NAVBAR
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.blue,
            child: const Center(
              child: Text(
                "BMSCE - Empty Classroom Tracker",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // 🔲 SIGNUP BOX
          Center(
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    "Create Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: "faculty",
                        groupValue: role,
                        onChanged: (val) {
                          setState(() => role = val.toString());
                        },
                      ),
                      const Text("Faculty"),
                      Radio(
                        value: "student",
                        groupValue: role,
                        onChanged: (val) {
                          setState(() => role = val.toString());
                        },
                      ),
                      const Text("Student"),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Sign Up"),
                  ),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Already have an account? Login"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
