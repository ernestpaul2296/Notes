import 'package:hive/hive.dart' show Box;
import './hive.dart';

enum BOX_NAME { NOTES_BOX }

class Global {
  static final Map<BOX_NAME, Box> boxes = {
    BOX_NAME.NOTES_BOX: HiveInstance.notesBox
  };
}
