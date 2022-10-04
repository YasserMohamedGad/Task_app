import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frist_project/modules/archiveScreen.dart';
import 'package:flutter_frist_project/cubit/appStates.dart';
import 'package:flutter_frist_project/modules/doneScreen.dart';
import 'package:flutter_frist_project/modules/taskScreen.dart';
import 'package:sqflite/sqflite.dart';

class appCubit extends Cubit<appStates>{
  appCubit() : super(intialstate());

  static appCubit get(context)=>BlocProvider.of(context);
  int index=0;
  List<Widget> screens=[
    taskScreen(),
    doneScreen(),
    archiveScreen(),

  ];

List<String>title=[
   'New task',
  'Done task',
  'Archive task'
];
 void changeNavBottom(int current)
 {
   index=current;
   emit(appChangeStateNavBotton());
 }

  late Database database;
  List<Map>newtasks=[];
  List<Map>donetaskes=[];
  List<Map>archivedtaskes=[];
  bool isSheetBotom= false;
  IconData fabicon= Icons.add;


  void changeIconBottomCheet({
    @required bool? isSheet,
    @required IconData? icon,
  })
{

  isSheetBotom=isSheet!;
  fabicon=icon!;
  emit(appChangeBottomCheetIconeState());

}



  void creatDataBase(){
      openDatabase('todo.db',version: 1,
        onCreate: (database, version) {
          database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)').then((value) {
            print('table created');
          }).catchError((error){
            print(" error when create table ${error.toString()}  ");
          });
          print('database created');
        },
        onOpen: (database){
          getDatabase(database);
          print('database opend');
        }
    ).then((value) {
      database=value;
      emit(appCreateDataBaseState());
     });
  }
   insertDataBase({
    @required  String? title,
    @required String? date,
    @required String? time  })async {

    return await database.transaction((txn)async{
      txn.rawInsert('INSERT INTO tasks(title,date,time,status ) VALUES("$title","$date","$time","new")'
      ).then((value){
        print(" $value row inserted");
        emit(appInsertDataBaseState());

        getDatabase(database);




      }).catchError((error){
        print("error in insert raw${error.toString()}");

      });


    });

  }

    void getDatabase(database) {
    newtasks=[];
    archivedtaskes=[];
    donetaskes=[];
    emit(appInsertDataBaseLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value){
     value.forEach((element){
       if(element['status']=="new"){
         newtasks.add(element);
       }else if(element['status']=="done"){
         donetaskes.add(element);
       }else{
         archivedtaskes.add(element);
       }
       print(element);
     });
      emit(appGetDataBaseState());
    });

  }

void updateDataBase({
  @required String? status,
  @required int? id

}) async{

   database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', '$id']).then((value) {
     getDatabase(database);
        emit(appUpdateDataBaseState());
           print(value);

   });
  print('updated: $status');

}

  void deleteDataBase({
    @required int? id

  }) async{
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id'])
        .then((value) {
      getDatabase(database);
      emit(appDeleteDataBaseState());
      print(value);

    });
    print('updated: $id');

  }


}