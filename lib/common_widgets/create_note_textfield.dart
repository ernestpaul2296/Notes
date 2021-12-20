import 'package:flutter/material.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class CreateNoteTextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  double height;
  String hint;

  CreateNoteTextFieldWidget({
    required this.controller,
    required this.height,
    required this.hint,
  });

  // final node = FocusScope.of(context);
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
      ),
      width: MediaQuery.of(context).size.width / 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: TextField(
          textInputAction: TextInputAction.done,
          maxLines: null,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onSubmitted: (event) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          autofocus: false,
          controller: controller,
          cursorColor: Colors.black,
          scrollPadding: EdgeInsets.symmetric(
            horizontal: 0,
          ),
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}
