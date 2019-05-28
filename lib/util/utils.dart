import 'package:flutter/material.dart';
import 'package:flutter_lottery/res/colors.dart';
import 'package:flutter_lottery/res/consts.dart';
//import 'package:fluttertoast/fluttertoast.dart';


class Utils {
  static getLotteryItemRedCount(String lottery) {
    int count = 0;
    switch (lottery) {
      case Const.SSQ:
        count = 6;
        break;
      case Const.DLT:
        count = 5;
        break;
      case Const.QLC:
      case Const.QXC:
        count = 7;
        break;
      case Const.PLS:
      case Const.FCSD:
        count = 3;
        break;
      case Const.PLW:
        count = 5;
        break;
    }
    return count;
  }

  static getLotteryItemColor(int index, String lottery) {
    return index <= Utils.getLotteryItemRedCount(lottery)
        ? lottery == Const.DLT ? ResColor.color_ED8431 : ResColor.color_F63F3F
        : lottery == Const.DLT ? ResColor.color_696BC9 :ResColor.color_508CEE;
  }

  static showToast(String msg) {
//    Fluttertoast.showToast(msg: msg, backgroundColor: ResColor.color_666666);
  }
}
