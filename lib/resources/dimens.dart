import 'package:flutter/material.dart';

class UIDimentions {
  static const defaultPadding = EdgeInsets.all(10);
  static const likeIconSize = 24.0;
  static const smallImageHeight = 200.0;
  static const fullImageHeight = 500.0;
  static const gridPadding = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 350,
      mainAxisExtent: 300,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10);
}
