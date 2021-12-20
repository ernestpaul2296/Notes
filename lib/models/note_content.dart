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
  String? text;
  @HiveField(10)
  double? startPointX;
  @HiveField(11)
  double? endPointX;
  @HiveField(12)
  double? startPointY;
  @HiveField(13)
  double? endPointY;
  @HiveField(14)
  double? controlPointX;
  @HiveField(15)
  double? controlPointY;
  @HiveField(16)
  double? centreX;
  @HiveField(17)
  double? centreY;
  NoteContent({
    required this.noteContentType,
    required this.positionX,
    required this.positionY,
    required this.height,
    required this.width,
    required this.color,
    this.fontSize,
    required this.noteContentId,
    required this.borderColor,
    this.text,
    this.startPointX,
    this.endPointX,
    this.startPointY,
    this.endPointY,
    this.controlPointX,
    this.controlPointY,
    this.centreX,
    this.centreY,
  });
}
