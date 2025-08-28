import 'dart:developer';
import 'dart:io';

import 'package:bluegeneration/donation/garbage_type.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_core;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_utils/api_client.dart';
import '../shared_utils/loading_dialog.dart';

class ImageViewPage extends StatefulWidget {
  final String imagePath;

  const ImageViewPage({super.key, required this.imagePath});

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  List<GarbageType> garbage_types = [];
  GarbageType? selectedGarbageType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          Expanded(child: Center(child: Image.file(File(widget.imagePath)))),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: DropdownMenu<GarbageType>(
                initialSelection: null,
                hintText: "Select Garbage Type",
                width: MediaQuery.of(context).size.width*8/10,

                onSelected: (GarbageType? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    selectedGarbageType = value;
                  });
                },
                dropdownMenuEntries: garbage_types
                    .map((e) => DropdownMenuEntry(value: e, label: e.name))
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final storageRef = FirebaseStorage.instance.ref();
                        final refString =
                            "image_${DateTime.now().toIso8601String()}.png";
                        final imageRef = storageRef.child(refString);

                        try {
                          File file = File(widget.imagePath);
                          imageRef.putFile(file).snapshotEvents.listen(
                            (event) async {
                              if (event.state == TaskState.running) {
                                showLoadingDialog(context);
                              } else if (event.state == TaskState.error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Image upload failed.",
                                    ),
                                  ),
                                );
                              } else {
                                final apiClient = ApiClient();
                                final pref =
                                    await SharedPreferences.getInstance();
                                final user_id = pref.getString("user_id");
                                final response = await apiClient.post(
                                  "/report/insertReport",
                                  data: {
                                    'photo': refString,
                                    'user_id': user_id,
                                  },
                                );
                                hideLoadingDialog(context);

                                if (response.statusCode == 201) {
                                  hideLoadingDialog(context);
                                  Navigator.pushNamed(
                                      context, "/confirmation_screen");
                                } else {
                                  hideLoadingDialog(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Failed to upload photo.",
                                      ),
                                    ),
                                  );
                                }
                              }

                              // switch(event.state){
                              //   case TaskState.paused:
                              //     log("Upload file paused");
                              //   case TaskState.running:
                              //     log("Upload file running");
                              //   case TaskState.success:
                              //     log("Upload file success");
                              //   case TaskState.canceled:
                              //     log("Upload file canceled");
                              //   case TaskState.error:
                              //     log("Upload file error");
                              // }
                            },
                          );
                        } on firebase_core.FirebaseException catch (e) {
                          log("FirebaseException upload error:$e");
                        } catch (e) {
                          log("Firebase upload error:$e");
                        }
                      },
                      child: Text("I'm satisfied!",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: Size(200, 50)),
                    ),
                    SizedBox(
                      height: 20,
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
                          backgroundColor: Colors.blue,
                          fixedSize: Size(200, 50)),
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoadingDialog(context);
      final apiClient = ApiClient();
      apiClient.get("/garbage_type/fetchGarbageTypes").then((response) {
        final responseMap = response.data as Map<String, dynamic>;
        final garbage_types = responseMap["garbage_types"] as List<dynamic>;
        for (var value in garbage_types) {
          final map = value as Map<String, dynamic>;
          final garbage_type = GarbageType(id: map["id"], name: map["name"]);
          setState(() {
            this.garbage_types = [...this.garbage_types, garbage_type];
          });
        }
        hideLoadingDialog(context);
      });
    });
  }
}
