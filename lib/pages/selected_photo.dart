import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/pages/polling_yes.dart';
import 'package:ollie_photo_social/pages/set_polling_yes.dart';

class SelectedPhotosPage extends StatefulWidget {
  SelectedPhotosPage(
      {Key key,
      this.selectedIndex,
      this.imagePath,
      this.createMode,
      this.photosPath})
      : super(key: key);

  final int selectedIndex;
  final String imagePath;
  final bool createMode;
  final List<String> photosPath;

  @override
  _SelectedPhotosPageState createState() => _SelectedPhotosPageState();
}

class _SelectedPhotosPageState extends State<SelectedPhotosPage> {
  List<String> photosPath = [];
  int selectedIndex = 0;

  void _changePhoto(int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PollingYesPage(
            selectedIndex: idx, createMode: false, photosPath: photosPath),
      ),
    );
  }

  void _removePhoto(int idx) {
    setState(() {
      if (idx == selectedIndex) selectedIndex = 0;
      if (photosPath.length == 1) selectedIndex = -1;
      photosPath.removeAt(idx);
    });
  }

  void _addPhoto() {
    if (photosPath.length >= 4) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PollingYesPage(createMode: true, photosPath: photosPath),
      ),
    );
  }

  List<Widget> _buildPhotoList() {
    List<Widget> photosList = [];
    for (int i = 0; i < photosPath.length; i++) {
      photosList.add(_buildPhotoItem(i));
    }
    return photosList;
  }

  Widget _buildPhotoItem(int index) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          InkWell(
            onTap: () => _changePhoto(index),
            child: Container(
              margin:
                  EdgeInsets.only(top: appPadding / 3, right: appPadding / 3),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: white,
                ),
                image: DecorationImage(
                  image: Image.file(File(photosPath[index])).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _removePhoto(index),
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
      ),
    );
  }

  @override
  void initState() {
    final imagePath = widget.imagePath;
    final mode = widget.createMode;
    final idx = widget.selectedIndex;

    setState(() {
      if (mode) {
        widget.photosPath.add(imagePath);
        selectedIndex = widget.photosPath.length - 1;
      } else {
        widget.photosPath[idx] = imagePath;
        selectedIndex = idx;
      }
      photosPath = widget.photosPath;
    });
    super.initState();
  }

  void nextAction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPollingYesPage(
          photosPath: widget.photosPath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image(
              image: (photosPath.isEmpty || selectedIndex == -1)
                  ? AssetImage("assets/images/layout/new_polling_topbar.png")
                  : Image.file(File(photosPath[selectedIndex])).image,
              fit: BoxFit.cover,
            ),
          ),
          PollingBackIcon(),
          Container(
            padding: EdgeInsets.all(appPadding),
            width: size.width,
            height: size.height,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: _buildPhotoList(),
            ),
          ),
          BottomNextIcon(
            nextAction: nextAction,
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(left: appPadding, bottom: appPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: size.width / 8,
                  height: size.width / 8,
                  child: InkWell(
                    onTap: () => _addPhoto(),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
