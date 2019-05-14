import 'package:flutter/material.dart';
import 'package:flutter_lottery/res/colors.dart';

class Utils {
  static getLotteryItemRedCount(String lottery) {
    int count = 0;
    switch (lottery) {
      case "ssq":
        count = 6;
        break;
      case "dlt":
        count = 5;
        break;
    }
    return count;
  }

  static getLotteryItemColor(String lottery) {
    Color color;
    switch (lottery) {
      case "ssq":
        color = ResColor.color_508CEE;
        break;
      case "dlt":
        break;
    }
    return color;
  }
}
