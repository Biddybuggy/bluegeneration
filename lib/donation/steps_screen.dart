import 'dart:ui';

import 'package:flutter/material.dart';
class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  static const routeName = "/steps_screen";
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Center(child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: const Text("DONATION STEPS", style:TextStyle(fontWeight:FontWeight.bold, fontSize:50,), textAlign:TextAlign.center)),
          SizedBox(
            height:MediaQuery.of(context).size.height*1/20,
          ),
          const Text("1. Clear your trash of any food or liquids.", style:TextStyle(fontSize:30,)),
          SizedBox(
            height:MediaQuery.of(context).size.height*1/25,
          ),
          const Text("2. Make sure your trash fits in Blu:Gen's criteria.", style:TextStyle(fontSize:30,)),
          SizedBox(
            height:MediaQuery.of(context).size.height*1/25,
          ),
          const Text("3. Write down your username on your trash.", style:TextStyle(fontSize:30,)),
          SizedBox(
            height:MediaQuery.of(context).size.height*1/20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/camera_screen");
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(300, 40),
                shape: StadiumBorder()),
            child: const Text("I'm Ready!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ],
      ),
    ))));
  }
}
