import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'note_content.g.dart';

@HiveType(typeId: 2)
class NoteContent {
  @HiveField(0)
  String noteContentType;
  @HiveField(1)
  double positionX;
  @HiveField(2)
  double positionY;
  @HiveField(3)
  double height;
  @HiveField(4)
  double width;
  @HiveField(5)
  int color;
  @HiveField(6)
  double? fontSize;
  @HiveField(7)
  String noteContentId;
  @HiveField(8)
  int borderColor;
  @HiveField(9)
  String? data;
  @HiveField(10)
  List<String> connectedComponents;
  NoteContent({
    required this.connectedComponents,
    required this.noteContentType,
    required this.positionX,
    required this.positionY,
    required this.height,
    required this.width,
    required this.color,
    this.fontSize,
    required this.noteContentId,
    required this.borderColor,
    this.data,
  });
}
