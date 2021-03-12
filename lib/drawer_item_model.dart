import 'package:flutter/cupertino.dart';
import 'package:flutter_animation/drawer_index.dart';

class DrawerItemModel {
  final String title;
  final String assetName;
  final bool isAsset;
  final IconData iconData;
  final DrawerIndex drawerIndex;

  DrawerItemModel(
      {@required this.title,
      @required this.drawerIndex,
      this.assetName,
      this.isAsset: false,
      this.iconData}) {
    assert(iconData != null || assetName != null);
  }
}
