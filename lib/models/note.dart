import 'package:surfwar_flutter/models/note_content.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime createdOn;
  @HiveField(4)
  DateTime lastEditedOn;
  @HiveField(5)
  List<NoteContent> noteContent;
  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdOn,
    required this.lastEditedOn,
    required this.noteContent,
  });
}
