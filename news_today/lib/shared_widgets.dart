import 'package:flutter/material.dart';
import 'package:news_today/helpers/shared.dart';

Widget appImagePlaceholder(Color color, {bool isCircle = false}) {
  return Container(
      decoration: isCircle
          ? BoxDecoration(shape: BoxShape.circle, color: color)
          : BoxDecoration(
              color: color.withOpacity(0.4),
              borderRadius: BorderRadius.circular(radius1)),
      height: double.maxFinite,
      width: double.maxFinite);
}
