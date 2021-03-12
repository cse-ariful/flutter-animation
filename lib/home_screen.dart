import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

int c = 0;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("building home screen ${c++}");
    return Container(
      child: Center(
        child: Text(
          "Home Screen",
        ),
      ),
    );
  }
}
