import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

class TakePictureScreen extends StatefulWidget {
  
  const TakePictureScreen ({super.key,});
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
 
  List<CameraDescription> cameras = [];
  CameraController? controller;

  @override
  void initState(){
    super.initState();
    _setUpCameraController();
  }

 @override
 Widget build(BuildContext context) {
  return Scaffold(
    body: _cameraUI(),
  );
 }

 Widget _cameraUI() {
  if(controller == null || controller?.value.isInitialized == false) {
    return const Center(child: CircularProgressIndicator(),);
  }

  return SafeArea(child: SizedBox.expand(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: MediaQuery.sizeOf(context).width * 0.80,
          child: CameraPreview(controller!,)),
        IconButton(
          onPressed: () async {
            XFile picture = await controller!.takePicture();
            Navigator.pop(context, picture.path);
            Gal.putImage(picture.path);
          },
          icon: const Icon(Icons.camera, color: Colors.blue, size: 100)
        )
      ]
    ),
  ),
  );
 }

 Future<void> _setUpCameraController() async {
  List<CameraDescription> _cameras = await availableCameras();
  if(_cameras.isNotEmpty) {
    setState(() {
      cameras = _cameras;
      controller = CameraController(_cameras.first, ResolutionPreset.medium);
    });
    controller?.initialize().then((_){
      setState((){});
    });
  }
 } 
  
}
