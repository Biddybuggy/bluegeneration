import 'package:bluegeneration/donation/steps_screen.dart';
import 'package:bluegeneration/home/home_screen.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  static const routeName = "/confirmation_screen";

  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Your trash is ready to go!",style:TextStyle(fontSize:50,fontWeight:FontWeight.bold,),textAlign:TextAlign.center,),
                        SizedBox(
                          height:MediaQuery.of(context).size.height*1/20,
                        ),
                        Image.asset(
                          'images/truck.jpg',
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height:MediaQuery.of(context).size.height*1/20,
                        ),
                        const Text("Your account will be updated soon.",style:TextStyle(fontSize:30),textAlign:TextAlign.center,),
                        SizedBox(
                          height:MediaQuery.of(context).size.height*1/20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).popUntil((route) => route is MaterialPageRoute && route.builder(context) is HomeScreen,);
                            },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: const Size(300, 40),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text("Back",
                              style: TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ]),
                ))));
  }
}
