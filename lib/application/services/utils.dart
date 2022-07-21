import 'dart:async';

import 'package:flutter/material.dart';

Timer getTimer(
    {int duration = 3,
    required PageController pageController,
    required int pageNumber}) {
  return Timer.periodic(Duration(seconds: duration), (timer) {
    pageController.animateToPage(pageNumber,
        duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
    pageNumber++;
  });
}
