// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '404, NOT FOUND!',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
