import 'package:hive_flutter/hive_flutter.dart';

part 'style_model.g.dart';

@HiveType(typeId: 3)
class TextStyleProp {
  @HiveField(0)
  double? fontSize;
  @HiveField(1)
  bool textThinkness;
  @HiveField(2)
  bool textItalics;
  @HiveField(3)
  bool textUnderline;
  @HiveField(4)
  int colorCode;

  TextStyleProp(
      {this.fontSize,
      required this.colorCode,
      required this.textItalics,
      required this.textThinkness,
      required this.textUnderline});
}
