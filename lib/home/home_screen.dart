import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.username});
  final String username;

  @override
  static const routeName = "/home_screen";
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _storedUsername;

  // Replace these with your real values / state from backend, provider, etc.
  int plasticBottles = 128;
  int otherInorganic = 57;
  double cookingOilLiters = 12.3;
  int tablesCreated = 4;
  double co2ReducedKg = 256.7;

  final NumberFormat numFmt = NumberFormat.decimalPattern();
  final NumberFormat compactFmt = NumberFormat.compact();

  @override
  void initState() {
    super.initState();
    _storedUsername = widget.username;
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
                  height: 140, // fixed height for cards + padding
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
                        const SizedBox(width:12),
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
                  height: 140, // fixed height for cards + padding
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
                        // 👉 add more StatCards if needed, scrolling will handle overflow
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

/// A small, reusable stat card that keeps the title and shows a big number.
/// Uses Wrap + constrained size + ellipsis to prevent overflows.
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
        maxWidth: 170, // keeps lines from getting too long on tablets
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
            // Title (wrap to up to 2 lines, ellipsize if still too long)
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
            // Big number – FittedBox ensures it scales down to fit if needed
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
