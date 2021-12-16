import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surfwar_flutter/models/note_content.dart';

class HiveInstance {
  static late Box _notesBox;
  static initialiseHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(NoteContentAdapter());
    _notesBox = await Hive.openBox('notes_box');
  }

  static Box get notesBox {
    return _notesBox;
  }
}
