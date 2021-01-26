import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/constants.dart';
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
    this.thisPhotos,
    this.thatPhotos,
    this.selectedThisIndex,
    this.selectedThatIndex,
    this.createMode,
  }) : super(key: key);

  final bool thisThat;
  final String imagePath;
  final List<String> thisPhotos, thatPhotos;
  final int selectedThisIndex, selectedThatIndex;
  final bool createMode;

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
  List<String> thisPhotosPath = [], thatPhotosPath = [];
  bool noCamera = false;
  bool createMode;
  int selectedThisIndex = 0, selectedThatIndex = 0;

  @override
  void initState() {
    super.initState();
    getCameras();
    if (widget.thisThat != null && widget.createMode != null) {
      setState(() {
        thisPhotosPath = widget.thisPhotos;
        thatPhotosPath = widget.thatPhotos;
        thisSelected = widget.thisThat;
        createMode = null;
        selectedThisIndex = widget.createMode && widget.thisThat
            ? widget.thisPhotos.length - 1
            : widget.selectedThisIndex;
        selectedThatIndex = widget.createMode && !widget.thisThat
            ? widget.thatPhotos.length - 1
            : widget.selectedThatIndex;
      });
    }
  }

  @override
  void dispose() {
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

  bool thisPhotosEmpty() {
    return thisPhotosPath == null || thisPhotosPath.isEmpty;
  }

  bool thatPhotosEmpty() {
    return thatPhotosPath == null || thatPhotosPath.isEmpty;
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

  void nextAction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPollingThisPage(
          thisImage: thisPhotosPath,
          thatImage: thatPhotosPath,
        ),
      ),
    );
  }

  void _takePicture() async {
    try {
      await _initializeControllerFuture;
      XFile picture = await _controller.takePicture();
      String imgPath = picture.path;
      setState(() {
        if (createMode == null || createMode) {
          if (thisSelected)
            thisPhotosPath.add(imgPath);
          else
            thisPhotosPath.add(imgPath);
        } else {
          if (thisSelected)
            thisPhotosPath[selectedThisIndex] = imgPath;
          else
            thatPhotosPath[selectedThatIndex] = imgPath;
        }
      });
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
          thisPhotosPath: thisPhotosPath,
          thatPhotosPath: thatPhotosPath,
          createMode: createMode,
          selectedThisIndex: selectedThisIndex,
          selectedThatIndex: selectedThatIndex,
        ),
      ),
    );
  }

  void _selectPreviewer(bool isThis) {
    setState(() {
      thisSelected = isThis;
      createMode =
          (isThis ? thisPhotosEmpty() : thatPhotosEmpty()) ? true : false;
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

  void _changePhoto(bool isThis, int idx) {
    setState(() {
      thisSelected = isThis;
      if (isThis)
        selectedThisIndex = idx;
      else
        selectedThatIndex = idx;
      createMode = false;
    });
  }

  void _removePhoto(bool isThis, int idx) {
    setState(() {
      if (isThis)
        selectedThisIndex = 0;
      else
        selectedThatIndex = 0;

      if (isThis) {
        // if (thisPhotosPath.length == 1) selectedThisIndex = -1;
        thisPhotosPath.removeAt(idx);
      } else {
        // if (thatPhotosPath.length == 1) selectedThatIndex = -1;
        thatPhotosPath.removeAt(idx);
      }
    });
  }

  void _addPhoto(bool isThis) {
    List<String> photos = isThis ? thisPhotosPath : thatPhotosPath;
    if (photos != null && photos.length >= 4) return;
    setState(() {
      thisSelected = isThis;
      createMode = true;
    });
  }

  List<Widget> _buildPhotoList(bool isThis) {
    List<String> photos = isThis ? thisPhotosPath : thatPhotosPath;
    if (photos == null || photos.isEmpty) return [SizedBox(height: 30)];
    return List.generate(photos.length, (idx) => _buildPhotoItem(isThis, idx));
  }

  Widget _buildAddPhotoBtn(bool isThis) {
    return InkWell(
        onTap: () => _addPhoto(isThis),
        child: Container(
          width: 32,
          height: 32,
          margin: EdgeInsets.only(bottom: appPadding / 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            color: black,
            size: 32,
          ),
        ));
  }

  Widget _buildPhotoItem(bool isThis, int index) {
    List<String> photos = isThis ? thisPhotosPath : thatPhotosPath;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        InkWell(
          onTap: () => _changePhoto(isThis, index),
          child: Container(
            margin: EdgeInsets.only(top: appPadding / 3, right: appPadding / 4),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: white,
              ),
              image: DecorationImage(
                image: Image.file(File(photos[index])).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => _removePhoto(isThis, index),
          child: Container(
            width: appPadding * 2 / 3,
            height: appPadding * 2 / 3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close, color: black, size: appPadding / 2),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoBrowser(bool isThis) {
    bool emptyPhotos =
        isThis == thisSelected ? thisPhotosEmpty() : thatPhotosEmpty();
    bool selectorShow =
        (createMode != null || emptyPhotos) && isThis == thisSelected;
    return selectorShow
        ? Container(
            padding: EdgeInsets.all(appPadding * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
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
                InkWell(
                  onTap: () => noCamera ? {} : _takePicture(),
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
                      child: Icon(Icons.stop,
                          color: noCamera ? gray3Color : white, size: 20),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => noCamera ? {} : _switchCamera(),
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
          )
        : Container(
            padding: EdgeInsets.all(appPadding),
            margin: EdgeInsets.only(top: appPadding * 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAddPhotoBtn(isThis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildPhotoList(isThis),
                ),
              ],
            ));
  }

  Widget _buildPhotoPreviewer(BuildContext context, snapshot, bool isThis) {
    Size size = MediaQuery.of(context).size;
    List<String> imagePaths = isThis ? thisPhotosPath : thatPhotosPath;
    bool noImage = imagePaths == null || imagePaths.isEmpty;
    bool cameraShow = noImage &&
        isThis == thisSelected &&
        snapshot.connectionState == ConnectionState.done;

    return GestureDetector(
        onTap: () => _selectPreviewer(isThis),
        child: Container(
          width: size.width / 2,
          height: size.height,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: gray2Color, width: .4),
            ),
            color: Color.fromRGBO(0, 0, 0, 0.8),
          ),
          child: !noImage
              ? Stack(children: [
                  Container(
                    color: red,
                    height: size.height,
                    child: Image(
                      image: Image.file(File(imagePaths[
                              isThis ? selectedThisIndex : selectedThatIndex]))
                          .image,
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
                  ? (noCamera
                      ? Center(
                          child: Text(
                            "No Cameras.",
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                        )
                      : CameraPreview(_controller))
                  : Center(
                      // child: CircularProgressIndicator(),
                      )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool completed = (thisPhotosPath != null &&
        thatPhotosPath != null &&
        !thisPhotosPath.isEmpty &&
        !thatPhotosPath.isEmpty);
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
                        _buildPhotoBrowser(true),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _buildPhotoPreviewer(context, snapshot, false),
                        _buildPhotoBrowser(false),
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
