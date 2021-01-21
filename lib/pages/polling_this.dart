import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:ollie_photo_social/pages/gallery.dart';
import 'package:ollie_photo_social/pages/selected_photo.dart';
import 'package:ollie_photo_social/pages/set_polling_this.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class PollingThisPage extends StatefulWidget {
  PollingThisPage({
    Key key,
    this.thisThat,
    this.imagePath,
    this.thisImage,
    this.thatImage,
  }) : super(key: key);

  final bool thisThat;
  final String imagePath;
  final String thisImage, thatImage;

  @override
  _PollingThisPageState createState() => _PollingThisPageState();
}

class _PollingThisPageState extends State<PollingThisPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  List<CameraDescription> cameras;
  bool frontCamera;
  bool thisSelected = true;
  String thisImagePath, thatImagePath;

  @override
  void initState() {
    if (widget.thisThat != null && widget.imagePath != null) {
      String galleryImg = widget.imagePath;
      setState(() {
        thisImagePath = widget.thisThat ? galleryImg : widget.thisImage;
        thatImagePath = widget.thisThat ? widget.thatImage : galleryImg;
      });
    }
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
    setState(() {
      frontCamera = true;
      _controller = CameraController(
        cameras[frontCamera ? 0 : 1],
        ResolutionPreset.ultraHigh,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  void _switchCamera() {
    setState(() {
      frontCamera = !frontCamera;
      _controller = CameraController(
        cameras[frontCamera ? 0 : 1],
        ResolutionPreset.ultraHigh,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  void nextAction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPollingThisPage(
          thisImage: thisImagePath,
          thatImage: thatImagePath,
        ),
      ),
    );
  }

  void _takePicture() async {
    try {
      await _initializeControllerFuture;
      XFile picture = await _controller.takePicture();
      setState(() {
        if (thisSelected)
          thisImagePath = picture.path;
        else
          thatImagePath = picture.path;
      });

      if (thisImagePath != null &&
          thatImagePath != null &&
          thisImagePath.isNotEmpty &&
          thatImagePath.isNotEmpty) print('next step');
      /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedPhotosPage(
              selectedIndex: widget.selectedIndex,
              imagePath: picture.path,
              createMode: widget.createMode,
              photosPath: widget.photosPath,
            ),
          ),
        ); */
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
            thisThatPage: true,
            isThis: thisSelected == null || thisSelected,
            thisImage: thisImagePath,
            thatImage: thatImagePath),
      ),
    );
  }

  void _selectPreviewer(bool isThis) {
    setState(() {
      thisSelected = isThis;
    });
  }

  void _removeImage(bool isThis) {
    setState(() {
      if (isThis)
        thisImagePath = null;
      else
        thatImagePath = null;
    });
  }

  Widget _buildPhotoSelector(bool isThis) {
    bool completed = (thisImagePath != null &&
        thatImagePath != null &&
        thisImagePath.isNotEmpty &&
        thatImagePath.isNotEmpty);
    bool selectorShow = !completed && thisSelected == isThis;
    return selectorShow
        ? Container(
            padding: EdgeInsets.all(appPadding * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _openGallery(),
                  child: Container(
                    width: appPadding,
                    height: appPadding,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: white,
                      ),
                      image: DecorationImage(
                          image: AssetImage("assets/images/avatar/user1.jpeg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _takePicture(),
                  child: Container(
                    alignment: Alignment.center,
                    width: appPadding * 1.6,
                    height: appPadding * 1.6,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: white),
                      color: Color.fromRGBO(255, 255, 255, .05),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: appPadding,
                      height: appPadding,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.stop, color: white, size: 20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _switchCamera(),
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: Icon(
                      Icons.autorenew,
                      size: 40,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildPhotoPreviewer(BuildContext context, snapshot, bool isThis) {
    Size size = MediaQuery.of(context).size;
    String imagePath = isThis ? thisImagePath : thatImagePath;
    bool noImage = imagePath == null || imagePath.isEmpty;
    bool cameraShow = noImage &&
        isThis == thisSelected &&
        snapshot.connectionState == ConnectionState.done;

    return GestureDetector(
        onTap: () => _selectPreviewer(isThis),
        child: Container(
          width: size.width / 2,
          height: size.height,
          color: Color.fromRGBO(0, 0, 0, 0.8),
          child: !noImage
              ? Stack(children: [
                  Container(
                    color: red,
                    height: size.height,
                    child: Image(
                      image: Image.file(File(imagePath)).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: appPadding * 1.5, left: appPadding),
                    child: InkWell(
                      onTap: () => _removeImage(isThis),
                      child: Icon(
                        Icons.close,
                        size: 32,
                        color: white,
                      ),
                    ),
                  ),
                ])
              : (cameraShow
                  ? CameraPreview(_controller)
                  : Center(
                      // child: CircularProgressIndicator(),
                      )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool completed = (thisImagePath != null &&
        thatImagePath != null &&
        thisImagePath.isNotEmpty &&
        thatImagePath.isNotEmpty);
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          return Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _buildPhotoPreviewer(context, snapshot, true),
                        _buildPhotoSelector(true),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _buildPhotoPreviewer(context, snapshot, false),
                        _buildPhotoSelector(false),
                      ],
                    ),
                  ),
                ],
              ),
              completed
                  ? BottomNextIcon(
                      nextAction: nextAction,
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
