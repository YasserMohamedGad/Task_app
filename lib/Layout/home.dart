
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frist_project/modules/archiveScreen.dart';
import 'package:flutter_frist_project/shared/component/constants.dart';
import 'package:flutter_frist_project/cubit/appCubit.dart';
import 'package:flutter_frist_project/cubit/appStates.dart';
import 'package:flutter_frist_project/modules/doneScreen.dart';
import 'package:flutter_frist_project/modules/taskScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';






class HomeScreen extends StatelessWidget
{
  var taskControler=TextEditingController();
  var timeControler=TextEditingController();
  var dateControler=TextEditingController();
  var scafoldKey =GlobalKey<ScaffoldState>();
  var formKey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>appCubit()..creatDataBase(),
      child: BlocConsumer<appCubit,appStates>(
        listener:(context,state){
          if(state is appInsertDataBaseState){
            Navigator.pop(context);
          }
        } ,
        builder: (context,state)
        {
          appCubit cubit=appCubit.get(context);
        return  Scaffold(
          key: scafoldKey,
          appBar: AppBar(
            title: Text("${cubit.title[cubit.index]}",
              style: TextStyle(fontSize: 15,),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(cubit.isSheetBotom){
                if(formKey.currentState!.validate()) {
                   cubit.insertDataBase(title: taskControler.text,
                       date: dateControler.text,
                       time: timeControler.text).then((value){
                      cubit.changeIconBottomCheet(isSheet:false,icon:Icons.edit);

                   });
                }

              }
              else{
                scafoldKey.currentState!.showBottomSheet((context){
                  return Container(
                    padding: EdgeInsetsDirectional.all(20),color:Colors.grey[100],
                    child: Form(
                      key: formKey,
                      child: Column(

                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: taskControler,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.text_fields,),
                                hintText: ' task ',
                                border:OutlineInputBorder() ),
                            onChanged: (value){
                              print(value);
                            },
                            onFieldSubmitted: (value){
                              print(value);
                            },
                            onTap: ()
                            {

                            },
                            validator: (String? value)
                            {

                            if(value!.isEmpty){
                              return('task must not be empty');
                            }

                            },

                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: timeControler,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.watch_later_outlined,),
                                hintText: 'Task time ',
                                border:OutlineInputBorder() ),
                            onChanged: (value){
                              print(value);
                            },
                            onFieldSubmitted: (value){
                              print(value);
                            },
                            onTap: ()
                            {
                              showTimePicker(context: context, initialTime:TimeOfDay.now()
                              ).then((value) {
                                timeControler.text=value!.format(context);
                                print(value.format(context));
                              }).catchError((error){
                                print('$error error in  task time');
                              });
                            },
                            validator: (String? value)
                            {

                            if(value!.isEmpty){
                              return('time must not be empty');
                            }

                            },

                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: dateControler,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today,),
                                hintText: 'Task date ',
                                border:OutlineInputBorder() ),
                            onChanged: (value){
                              print(value);
                            },
                            onFieldSubmitted: (value){
                              print(value);
                            },
                            onTap: ()
                            {

                              showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-11-25'),
                              ).then(( value) {
                                dateControler.text=DateFormat.yMMMd().format(value!);
                                print(value);
                              }).catchError((error){
                                print("$error there error in date formate");
                              });
                            },
                            validator: (String? value)
                            {

                            if(value!.isEmpty){
                              return('Date must not be empty');
                            }

                            },

                          ),

                        ],
                      ),
                    ),
                  );
                }).closed.then((value) {
                  cubit.changeIconBottomCheet(isSheet: false, icon:Icons.edit);

                });
                cubit.changeIconBottomCheet(isSheet: true, icon:Icons.add);
              }

            },
            child: Icon(cubit.fabicon),
          ),
          bottomNavigationBar: BottomNavigationBar(currentIndex: cubit.index,
            onTap: (value){
              cubit.changeNavBottom(value);
            },
            items: [BottomNavigationBarItem(icon:Icon(Icons.menu),
              label:"Task", ),
              BottomNavigationBarItem(icon:Icon(Icons.done_all_rounded),
                label:"Done", ),
              BottomNavigationBarItem(icon:Icon(Icons.archive_outlined),
                label:"Archive", ),

            ],),
          body:  ConditionalBuilder(
            condition: state is! appInsertDataBaseLoadingState,
            builder: (context) =>cubit.screens[cubit.index],
            fallback: (context)=> Center(
                child: CircularProgressIndicator()),
          ) ,

  );
        },
      ),
    );
  }


}
