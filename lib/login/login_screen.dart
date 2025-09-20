import 'package:bluegeneration/shared_utils/api_client.dart';
import 'package:bluegeneration/shared_utils/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Username: dylanjaya100
// Password: abcde12345

class LoginScreen extends StatefulWidget {
  static const routeName = "/login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Login",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 1 / 40),
                  Image.asset(
                    'images/logo.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 1 / 15,
                    child: TextField(
                      controller: usernamecontroller,
                      decoration: const InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3),
                          gapPadding: 10,
                        ),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 1 / 30),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 15,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: TextField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3),
                          gapPadding: 10,
                        ),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 1 / 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (usernamecontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill in both username and password."),
                          ),
                        );
                        return;
                      }

                      showLoadingDialog(context);
                      final apiClient = ApiClient();
                      try {
                        final response = await apiClient.post(
                          "/auth/login",
                          data: {
                            'username': usernamecontroller.text,
                            'password': passwordcontroller.text,
                          },
                        );

                        hideLoadingDialog(context);

                        if (!mounted) return;

                        if (response.statusCode == 200) {
                          final responseMap = response.data as Map<String, dynamic>;

                          final pref = await SharedPreferences.getInstance();
                          pref.setString("user_id", responseMap["user_id"] ?? "");
                          pref.setString("name", responseMap["name"] ?? "");
                          pref.setString("username",responseMap["username"] ?? "");

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/",(route) => route.settings.name == "/",
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invalid credentials, please try again."),
                            ),
                          );
                        }
                      } catch (e) {
                        hideLoadingDialog(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login failed: $e")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(300, 40),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 1 / 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register_screen');
                    },
                    child: const Text("Don't have an account? Register now.",
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent)),
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
