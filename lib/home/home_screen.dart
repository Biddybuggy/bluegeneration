import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  static const routeName = "/home_screen";
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Center(
          child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    child: const Text("Good morning, Dylan Jaya",
                        style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 30,
                ),
                const Text("Your Progress",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 30,
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      width:100,
                      height:100,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(
                              color: Colors.black, // Set border color
                              width: 3.0),   // Set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // Set rounded corner radius
                          boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                      ),
                      child: Text("Plastic Bottles",style:TextStyle(fontWeight:FontWeight.bold,)),
                    ),
                    Container(
                      width:100,
                      height:100,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(
                              color: Colors.black, // Set border color
                              width: 3.0),   // Set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // Set rounded corner radius
                          boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                      ),
                      child: Text("Other Inorganic Waste",style:TextStyle(fontWeight:FontWeight.bold,)),
                    ),
                    Container(
                      width:100,
                      height:100,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(
                              color: Colors.black, // Set border color
                              width: 3.0),   // Set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // Set rounded corner radius
                          boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                      ),
                      child: Text("Cooking Oil", style:TextStyle(fontWeight:FontWeight.bold,)),
                    )
                  ]
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/30,
                ),
                const Text("Your Impact",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 30,
                ),
                Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Container(
                        width:100,
                        height:100,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            border: Border.all(
                                color: Colors.black, // Set border color
                                width: 3.0),   // Set border width
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)), // Set rounded corner radius
                            boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                        ),
                        child: Text("Tables Created",style:TextStyle(fontWeight:FontWeight.bold,)),
                      ),
                      Container(
                        width:100,
                        height:100,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            border: Border.all(
                                color: Colors.black, // Set border color
                                width: 3.0),   // Set border width
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)), // Set rounded corner radius
                            boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                        ),
                        child: Text("CO2 Emissions Reduced",style:TextStyle(fontWeight:FontWeight.bold,)),
                      ),
                    ]
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/30,
                ),
                ElevatedButton(
                  onPressed: () {
                    const snackBar = SnackBar(content: Text('This button doesn\'t work right now, but M&M supremacy is real.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(300, 40),
                      shape: StadiumBorder()),
                  child: const Text("Donate Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
              ]),
        ),
      ),
    );
  }
}
