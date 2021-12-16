import 'package:flutter/material.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class EmptyNoteStateWidget extends StatelessWidget {
  const EmptyNoteStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Start by creating your first note!',
            style: AppFonts.primaryHeader,
          ),
        ],
      ),
    );
  }
}
