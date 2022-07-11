


import 'package:flutter/material.dart';

import '../../../styles/styles.dart';
import '../../home_page/home_page.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      backgroundColor: AppColors.grey,
      child: Icon(Icons.home),
    );
  }
}
