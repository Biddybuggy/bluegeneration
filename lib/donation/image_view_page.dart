import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_core;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageViewPage extends StatefulWidget {
  final String imagePath;

  const ImageViewPage({super.key, required this.imagePath});

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment:CrossAxisAlignment.center,
            children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: Text(
                "Your Picture",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(child: Image.file(File(widget.imagePath))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              
              color: Colors.white,
              child: Column(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                ElevatedButton(
                  onPressed: () {
                    final storageRef = FirebaseStorage.instance.ref();
                    final imageRef = storageRef.child("image_${DateTime.now().toIso8601String()}.png");

                    try{
                      File file = File(widget.imagePath);
                      imageRef.putFile(file).snapshotEvents.listen((event) {
                        switch(event.state){
                          case TaskState.paused:
                            log("Upload file paused");
                          case TaskState.running:
                            log("Upload file running");
                          case TaskState.success:
                            log("Upload file success");
                          case TaskState.canceled:
                            log("Upload file canceled");
                          case TaskState.error:
                            log("Upload file error");
                        }
                      },);
                    }on firebase_core.FirebaseException catch (e) {
                      log("FirebaseException upload error:$e");
                    }catch(e){
                      log("Firebase upload error:$e");
                    }


                    Navigator.pushNamed(context,"/confirmation_screen");
                  },
                  child: Text("I'm satisfied!",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, fixedSize: Size(200, 50)),
                ),
                SizedBox(
                  height:20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Retake",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, fixedSize: Size(200, 50)),
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
