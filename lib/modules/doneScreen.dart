import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frist_project/shared/component/component.dart';
import 'package:flutter_frist_project/shared/component/constants.dart';
import 'package:flutter_frist_project/cubit/appCubit.dart';
import 'package:flutter_frist_project/cubit/appStates.dart';


class doneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);
        var tasks=appCubit.get(context).donetaskes;
        return  taskBulider(tasks:tasks,context: context
        );
      },
    );
  }
}
