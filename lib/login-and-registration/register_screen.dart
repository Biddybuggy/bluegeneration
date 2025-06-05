import 'package:flutter/material.dart';
import 'package:bluegeneration/login-and-registration/login_screen.dart';
import 'package:dio/dio.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  static const routeName = "/register_screen";
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children:[
                const Text("Register",style:TextStyle(fontSize:50,fontWeight:FontWeight.bold,)),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/40,
                ),
                const Text("Join us in the Blue Breakthrough movement.",style:TextStyle(fontSize:18,)),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/20,
                ),
                SizedBox(
                  width:MediaQuery.of(context).size.width*95/100,
                  height:MediaQuery.of(context).size.height*1/15,
                  child: TextField(
                      controller:namecontroller,
                      decoration:const InputDecoration(
                          hintText:"Name",
                          border:OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.black,width:3),
                            gapPadding:10,
                          ),
                          hintStyle:TextStyle(
                            color:Colors.grey,
                            fontSize:20,
                          )
                      )
                  ),
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/30,
                ),
                SizedBox(
                  width:MediaQuery.of(context).size.width*95/100,
                  height:MediaQuery.of(context).size.height*1/15,
                  child: TextField(
                        controller:usernamecontroller,
                        decoration:const InputDecoration(
                            hintText:"Username",
                            border:OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black,width:3),
                              gapPadding:10,
                            ),
                            hintStyle:TextStyle(
                              color:Colors.grey,
                              fontSize:20,
                            )
                        )
                    ),
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/30,
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/15,
                  width:MediaQuery.of(context).size.width*95/100,
                  child: TextField(
                      controller:emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(

                          hintText:"Email",
                          border:OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.black,width:3),
                            gapPadding:10,
                          ),
                          hintStyle:TextStyle(
                            color:Colors.grey,
                            fontSize:20,
                          )
                      )
                  ),
                ),

                SizedBox(
                  height:MediaQuery.of(context).size.height*1/30,
                ),

                SizedBox(
                  height:MediaQuery.of(context).size.height*1/15,
                  width:MediaQuery.of(context).size.width*95/100,
                  child: TextField(
                      controller:passwordcontroller,
                      obscureText:true,
                      decoration:const InputDecoration(
                          hintText:"Password",
                          border:OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.black,width:3),
                            gapPadding:10,
                          ),
                          hintStyle:TextStyle(
                            color:Colors.grey,
                            fontSize:20,
                          )
                      )
                  ),
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*1/20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final dio = Dio();
                    await dio.post("$BASEURL/auth/register", data: {'email':emailcontroller.text,'name':namecontroller.text,'username': usernamecontroller.text, 'password': passwordcontroller.text});
                    Navigator.pushNamed(context, "/login_screen");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(300, 40),
                      shape: StadiumBorder()),
                  child: const Text("Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}
