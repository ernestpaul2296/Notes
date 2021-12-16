import 'package:flutter/material.dart';
import 'package:surfwar_flutter/pages/pages.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'dart:async';

import 'package:surfwar_flutter/services/hive.dart';
import 'package:surfwar_flutter/services/notes.dart';

import 'models/note.dart';
import 'models/note_content.dart';
import 'pages/note_page/note_page.dart';
import 'styles/styles.dart';

void main() async {
  await HiveInstance.initialiseHive();

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

// _onTapDown(TapDownDetails details) {
//   var x = details.globalPosition.dx;
//   var y = details.globalPosition.dy;
//   // or user the local position method to get the offset
//   print(details.localPosition);
//   print("tap down " + x.toString() + ", " + y.toString());
// }

// _onTapUp(TapUpDetails details) {
//   var x = details.globalPosition.dx;
//   var y = details.globalPosition.dy;
//   // or user the local position method to get the offset
//   print(details.localPosition);
//   print("tap up " + x.toString() + ", " + y.toString());
// }
