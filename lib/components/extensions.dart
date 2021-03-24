import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget backBtn(BuildContext context, {Color color: Colors.black}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Icon(
      Icons.arrow_back,
      color: color,
    ),
  );
}
