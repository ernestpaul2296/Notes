import 'package:flutter/material.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller;

  TextFieldWidget({
    required this.controller,
  });

  // final node = FocusScope.of(context);
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: TextField(
          maxLines: null,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onSubmitted: (event) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          autofocus: false,
          //keyboardType: TextInputType.number,
          controller: controller,
          cursorColor: Colors.black,
          scrollPadding: EdgeInsets.symmetric(
            horizontal: 0,
          ),
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.edit),
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
