import 'package:flutter/material.dart';
import 'package:flutter_lottery/bloc/BlocProvider.dart';
import 'package:flutter_lottery/bloc/MainBloc.dart';
import 'package:flutter_lottery/pages/lottery_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: BlocProvider<MainBloc>(
        bloc: MainBloc(),
        child: LotteryMain(),
      ),
    );
  }
}
