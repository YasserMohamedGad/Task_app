import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frist_project/shared/component/constants.dart';
import 'package:flutter_frist_project/Layout/home.dart';

void main() {

  Bloc.observer = MyBlocObserver();

  runApp(myapp());

}

class myapp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:HomeScreen(),

    );
  }


}




