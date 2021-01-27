import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:camera/camera.dart';
import 'package:ollie_photo_social/pages/gallery.dart';
import 'package:ollie_photo_social/pages/selected_photo.dart';
import 'package:photo_manager/photo_manager.dart';

class PollingYesPage extends StatefulWidget {
  PollingYesPage({
    Key key,
    this.selectedIndex,
    this.createMode,
    this.photosPath,
  }) : super(key: key);

  final int selectedIndex;
  final bool createMode;
  final List<String> photosPath;

  @override
  _PollingYesPageState createState() => _PollingYesPageState();
}

class _PollingYesPageState extends State<PollingYesPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  List<CameraDescription> cameras;
  bool frontCamera;
  bool noCamera = false;

  @override
  void initState() {
    super.initState();
    getCameras();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void getCameras() async {
    cameras = await availableCameras();
    _initCamera(false);
  }

  void _switchCamera() {
    _initCamera(true);
  }

  Future wait() async {
    return new Future.delayed(const Duration(milliseconds: 300), () => {});
  }

  void _initCamera(bool turn) {
    setState(() {
      if (cameras.length == 0)
        noCamera = true;
      else
        noCamera = false;

      if (turn)
        frontCamera = !frontCamera;
      else
        frontCamera = true;
      if (cameras.length != 0) {
        _controller = CameraController(
          cameras.length > 0 ? cameras[frontCamera ? 0 : 1] : null,
          ResolutionPreset.ultraHigh,
        );
      }
      _initializeControllerFuture =
          cameras.length == 0 ? wait() : _controller.initialize();
    });
  }

  void _takePicture() async {
    try {
      await _initializeControllerFuture;
      XFile picture = await _controller.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedPhotosPage(
            selectedIndex: widget.selectedIndex,
            imagePath: picture.path,
            createMode: widget.createMode,
            photosPath: widget.photosPath,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void _openGallery() async {
    final permitted = await PhotoManager.requestPermission();
    if (!permitted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GalleryPage(
          selectedIndex: widget.selectedIndex,
          createMode: widget.createMode,
          photosPath: widget.photosPath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: size.width,
                height: size.height,
                color: (snapshot.connectionState == ConnectionState.done &&
                        !noCamera)
                    ? Colors.transparent
                    : Color.fromRGBO(0, 0, 0, 0.8),
                child: (snapshot.connectionState == ConnectionState.done &&
                        !noCamera)
                    ? CameraPreview(_controller)
                    : !noCamera
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                            child: Text(
                              "There's no camera.",
                              style: TextStyle(color: white, fontSize: 20),
                            ),
                          ),
              ),
              Container(
                padding: EdgeInsets.all(appPadding * 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _openGallery(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: white,
                          ),
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/avatar/user1.jpeg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => noCamera
                          ? {print('cannot take picture')}
                          : _takePicture(),
                      child: Container(
                        alignment: Alignment.center,
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: white),
                          color: Color.fromRGBO(255, 255, 255, .05),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.stop, color: white, size: 20),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          noCamera ? {print('cannot switch')} : _switchCamera(),
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: Icon(
                          Icons.autorenew,
                          size: 40,
                          color: noCamera ? gray3Color : white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
