import 'package:bluegeneration/shared_utils/api_client.dart';
import 'package:bluegeneration/shared_utils/loading_dialog.dart';
import 'package:flutter/material.dart';

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
                      keyboardType: TextInputType.number,
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
                      showLoadingDialog(context);

                      final apiClient = ApiClient();
                      await apiClient.post(
                        "/auth/login",
                        data: {
                          'username': usernamecontroller.text,
                          'password': passwordcontroller.text
                        },
                      );

                      hideLoadingDialog(context);
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
