


import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../styles/styles.dart';
import '../../home_page/home_page.dart';
import '../view_model/note_page_viewmodel.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
       builder: (p0, isKeyboardVisible) {
        return Padding(
          padding:  EdgeInsets.only(bottom: isKeyboardVisible ?40:0 ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            backgroundColor: AppColors.grey,
            child: Icon(Icons.home),
          ),
        );
      }
    );
  }
}
