import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frist_project/shared/component/constants.dart';
import 'package:flutter_frist_project/cubit/appCubit.dart';
import 'package:flutter_frist_project/cubit/appStates.dart';
import 'package:flutter_frist_project/shared/component/component.dart';


class taskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit,appStates>(
      listener: (context,state){

      },
      builder: (context,state){
        appCubit cubit=appCubit.get(context);
        var tasks=appCubit.get(context).newtasks;
        return taskBulider(tasks:tasks,context: context
        );
      },
    );
  }


}
