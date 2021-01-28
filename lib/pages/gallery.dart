import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/polling_this.dart';
import 'package:ollie_photo_social/pages/selected_photo.dart';
import 'package:photo_manager/photo_manager.dart';

import 'admin/add_coupon.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({
    Key key,
    this.selectedIndex,
    this.selectedThisIndex,
    this.selectedThatIndex,
    this.createMode,
    this.photosPath,
    this.thisThatPage,
    this.isThis,
    this.thisImage,
    this.thatImage,
    this.thisPhotosPath,
    this.thatPhotosPath,
    this.couponPage,
    this.couponImage,
  }) : super(key: key);

  final int selectedIndex, selectedThisIndex, selectedThatIndex;
  final bool createMode;
  final List<String> photosPath, thisPhotosPath, thatPhotosPath;
  final bool thisThatPage, couponPage;
  final bool isThis;
  final String thisImage, thatImage, couponImage;

  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<GalleryPage> {
  List<AssetEntity> assets = [];

  void _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    if (albums.isEmpty) return;
    final recentAlbum = albums.first;

    final recentAssets =
        await recentAlbum.getAssetListRange(start: 0, end: 1000000);
    setState(() => assets = recentAssets);
  }

  Future<void> selectPhoto(AssetEntity entity) async {
    File assetFile = await entity.file;
    bool thisThatPage = widget.thisThatPage;
    bool couponPage = widget.couponPage;
    Widget routeWidget;

    if (couponPage != null && couponPage) {
      print('media image ${assetFile.path}');
      routeWidget = AddCouponPage(
        couponLogo: assetFile.path,
      );
    } else {
      if (thisThatPage == null || !thisThatPage)
        routeWidget = SelectedPhotosPage(
          selectedIndex: widget.selectedIndex,
          imagePath: assetFile.path,
          createMode: widget.createMode,
          photosPath: widget.photosPath,
        );
      else {
        List thisPhotos = widget.thisPhotosPath;
        List thatPhotos = widget.thatPhotosPath;
        if (widget.createMode == null || widget.createMode) {
          if (widget.isThis)
            thisPhotos.add(assetFile.path);
          else
            thatPhotos.add(assetFile.path);
        } else {
          if (widget.isThis)
            thisPhotos[widget.selectedThisIndex] = assetFile.path;
          else
            thatPhotos[widget.selectedThatIndex] = assetFile.path;
        }

        routeWidget = PollingThisPage(
          thisThat: widget.isThis,
          createMode: widget.createMode == null || widget.createMode,
          selectedThisIndex: widget.selectedThisIndex,
          selectedThatIndex: widget.selectedThatIndex,
          thisPhotos: thisPhotos,
          thatPhotos: thatPhotos,
        );
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => routeWidget,
      ),
    );
  }

  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        backgroundColor: primaryColor,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: assets.length,
        itemBuilder: (_, index) {
          return AssetThumbnail(
            asset: assets[index],
            selectPhoto: selectPhoto,
          );
        },
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    Key key,
    @required this.asset,
    @required this.selectPhoto,
  }) : super(key: key);

  final AssetEntity asset;
  final void Function(AssetEntity) selectPhoto;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null)
          return Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: CircularProgressIndicator());
        return GestureDetector(
          onTap: () => selectPhoto(asset),
          child: Image.memory(bytes, fit: BoxFit.cover),
        );
      },
    );
  }
}
