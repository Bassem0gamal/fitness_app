import 'package:flutter/material.dart';

import 'colors.dart';

const playIconDecoration = BoxDecoration(boxShadow: [
  BoxShadow(
    color: cGradientFirst,
    blurRadius: 10.0,
    offset: Offset(4, 8),
  )
]);

final hp1stContainerDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [
      cGradientFirst.withOpacity(0.9),
      cGradientSecond.withOpacity(0.9),
    ], begin: Alignment.bottomLeft, end: Alignment.topRight),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
      topRight: Radius.circular(80.0),
    ),
    boxShadow: [
      BoxShadow(
          offset: const Offset(5, 10),
          blurRadius: 20.0,
          color: cGradientSecond.withOpacity(0.5))
    ]);

final hp2ndContainerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(20),
    ),
    image: const DecorationImage(
        image: AssetImage('assets/logo 3.jpg'), fit: BoxFit.fill),
    boxShadow: [
      BoxShadow(
          blurRadius: 40.0,
          offset: const Offset(8, 10),
          color: cGradientSecond.withOpacity(0.3))
    ]);

final vs1stContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      cGradientFirst.withOpacity(0.9),
      cGradientSecond.withOpacity(0.9),
    ],
    begin: const FractionalOffset(0.0, 0.4),
    end: Alignment.topRight,
  ),
);

final vs2ndContainerDecoration =
    BoxDecoration(color: cGradientSecond.withOpacity(0.9));

final vs3rdDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.25),
  borderRadius: BorderRadius.circular(10.0),
);

const vs4thDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(80.0),
  ),
);

final vs5Decoration = BoxDecoration(
  color: const Color(0xFFeaeefc),
  borderRadius: BorderRadius.circular(10),
);
