// Loading screen to avoid spam after user presses I'm satisfied
// API for posting using backend controller
// Implement Reports Route (need user id, save user id in session)
// Shared Preference
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'image_view_page.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = "/camera_screen";

  const CameraScreen({super.key, required this.cameras});
  final List<CameraDescription> cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController? controller;
  late XFile? imageFile;

  void initCamera() {
    controller = CameraController(widget.cameras[1], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
    initCamera();
  }
  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (controller?.value?.isInitialized != true) {
      return Container();
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // App bar configuration
        ),
        body: Column(
          children: <Widget>[
            Container(
              color:Colors.white,
              child:Column(
                children: [
                  Text("Take a picture of your trash.",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),textAlign:TextAlign.center,),
                  Text("Make sure your username is seen.",style:TextStyle(fontSize: 30,),textAlign:TextAlign.center,),
                ],
              ),
            ),
            Expanded(flex:4,child: (controller != null)?CameraPreview(controller!):SizedBox()),

            Container(
              color:Colors.white,
              child:Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    _takePicture();
                  },
                  child:Text("Capture",style:TextStyle(fontSize: 20,color:Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,fixedSize: Size(200, 100)),
                ),
              )
            )

          ],
        ),
      ),
    );
  }
  void requestStoragePermission() async {
    // Check if the platform is not web, as web has no permissions
    if (!kIsWeb) {
      // Request storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      // Request camera permission
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }
    }
  }
  void _takePicture() async {
    try {
      final XFile? picture = await controller?.takePicture();
      final imagePath = (await path.getApplicationCacheDirectory()).path + DateTime.now().millisecondsSinceEpoch.toString() + ".png";
      picture?.saveTo(imagePath);
      setState(() {
        imageFile = XFile(imagePath);
      });
      // Navigate to the image view page after capturing the image

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewPage(imagePath: imageFile!.path),
        ),
      ).then((value) {
        initCamera();
      },);
      controller?.dispose();
      controller = null;
    } catch (e) {
      print("Error taking picture: $e");
    }
  }
}
