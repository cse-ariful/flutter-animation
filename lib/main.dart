import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/navigation_container_view.dart';
import 'package:sizer/sizer_util.dart';

import 'home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizerUtil().init(constraints, orientation);
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          home: HomeView(), // NavigationContainerView(),
        );
      });
    });
  }
}
