import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frist_project/shared/component/constants.dart';
import 'package:flutter_frist_project/cubit/appCubit.dart';

Widget taskItemBulider( Map model,context)=>  Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 45,

          child: Text("${model['time']}",

            style: TextStyle(

                fontWeight: FontWeight.bold),

          ),



        ),

        SizedBox(width: 15,),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Text("${model['title']}",

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 20),

              ),

              Text("${model['date']}"),



            ],

          ),

        ),

        SizedBox(width: 15,),

        IconButton(onPressed: (){



          appCubit.get(context).updateDataBase(status:"done",id: model["id"]);



          },

            icon: Icon(Icons.check_box,color: Colors.green,)

        ),



        IconButton(onPressed: (){

          appCubit.get(context).updateDataBase(status:'archive',id: model["id"]);



          },

            icon: Icon(Icons.archive,color: Colors.black38,)

        ),

      ],

    ),

  ),
  onDismissed: (direction){
    appCubit.get(context).deleteDataBase(id: model['id']);
  },
);


Widget taskBulider({
  @required List<Map>?tasks,
  context
}
    )=>ConditionalBuilder(

  condition:tasks!.length>0 ,
  builder:(context)=>ListView.separated(itemBuilder:(context,index)=>taskItemBulider(tasks[index],context),
      separatorBuilder: (context,index)=>Padding(
        padding: EdgeInsetsDirectional.only(start: 35),
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
      ),
      itemCount:tasks.length) ,
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,color: Colors.grey,size: 100,),
        Text('No Tasks Yet,Please Add Some Tasks',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.grey ),)
      ],
    ),
  ),
);