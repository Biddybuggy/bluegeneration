import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../shared_utils/api_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.username});
  final String username;

  @override
  static const routeName = "/home_screen";
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _storedUsername;
  String? _email; // store email

  double plasticBottles = 0;
  double otherInorganic = 0;
  double cookingOilLiters = 0;
  double tablesCreated = 0;
  double co2ReducedKg = 0;

  final NumberFormat numFmt = NumberFormat.decimalPattern();
  final NumberFormat compactFmt = NumberFormat.compact();

  @override
  void initState() {
    super.initState();
    _storedUsername = widget.username;
    _fetchEmail(); // fetch email on load
  }

  Future<void> _fetchEmail() async {
    final apiClient = ApiClient();
    try {
      final response = await apiClient.post(
        "/auth/get_email",
        data: {"username": _storedUsername},
      );

      final email = response.data['email'];
      setState(() {
        _email = email;
      });
      print("Fetched email: $_email");

      // 👇 Call progress fetch only after email is ready
      await _fetchUserProgress();

    } catch (e) {
      print("Error fetching email: $e");
    }
  }

  Future<void> _fetchUserProgress() async {
    if (_email == null) {
      print("⚠️ Cannot fetch progress, email is null");
      return;
    }

    final apiClient = ApiClient();
    try {
      final response = await apiClient.post(
        "/report/fetchProgressDetails",
        data: {"user_id": _email},
      );

      final garbageTypes = response.data["garbage_types"];
      final userProgress = response.data["user_progress"];

      print("Garbage types: $garbageTypes");
      print("User progress: $userProgress");

      // Map progress by garbage type
      Map<int, double> totals = {};
      for (var entry in userProgress) {
        final typeId = entry["garbage_type_id"] as int;
        final count = (entry["count"] as num).toDouble(); // now handles decimals
        totals[typeId] = (totals[typeId] ?? 0) + count;
      }

      setState(() {
        plasticBottles = totals[1] ?? 0.0;
        otherInorganic = totals[2] ?? 0.0;
        // Add cookingOilLiters, etc. if your backend returns those types
      });
    } catch (e) {
      print("Error fetching user progress: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final nowTime = DateTime.now();
    final hours = nowTime.hour;
    final greeting = (hours >= 5 && hours < 12)
        ? "Good Morning"
        : (hours >= 12 && hours < 17)
        ? "Good Afternoon"
        : "Good Evening";

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/logo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$greeting, $_storedUsername!",
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 8),
                const Text(
                  "Your Progress",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 1 / 30),

                // PROGRESS CARDS
                SizedBox(
                  height: 140,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StatCard(
                          title: "Plastic Bottles (kg)",
                          value: numFmt.format(plasticBottles),
                        ),
                        const SizedBox(width: 12),
                        StatCard(
                          title: "Other Inorganic Waste (kg)",
                          value: numFmt.format(otherInorganic),
                        ),
                        const SizedBox(width: 12),
                        StatCard(
                          title: "Cooking Oil (L)",
                          value: numFmt.format(cookingOilLiters),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 1 / 30),
                const Text(
                  "Your Impact",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 1 / 30),

                // IMPACT CARDS
                SizedBox(
                  height: 140,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StatCard(
                          title: "Tables Created",
                          value: numFmt.format(tablesCreated),
                        ),
                        const SizedBox(width: 12),
                        StatCard(
                          title: "CO₂ Emissions Reduced (kg)",
                          value: numFmt.format(co2ReducedKg),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 1 / 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/steps_screen");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: const Size(300, 40),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Donate Now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 120,
        maxWidth: 170,
        minHeight: 110,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          border: Border.all(color: Colors.black, width: 3.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
