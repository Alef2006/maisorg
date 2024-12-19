import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mais_org/entities/task.dart';

class Cardlist extends StatefulWidget {
  const Cardlist({super.key, required this.task,required this.action});

  final Task task;
  final Function action;

  @override
  State<Cardlist> createState() => _CardlistState();
}

class _CardlistState extends State<Cardlist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child:Slidable(
        endActionPane: ActionPane(
          extentRatio:0.25 ,
          motion: const DrawerMotion(), children:[
          SlidableAction(
            onPressed: delete,backgroundColor: Colors.red,icon: Icons.delete,)
        ]),
        child: Container(
         decoration:  const BoxDecoration(
           borderRadius: BorderRadius.only(
             bottomLeft: Radius.circular(5),
             bottomRight: Radius.circular(3),
             topLeft: Radius.circular(5),topRight:Radius.circular(3) ),
           color: Color.fromARGB(255, 37, 37, 37)
         ),
         child: Padding(
           padding: const EdgeInsets.all(5.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(widget.task.data,style:const  TextStyle(fontSize: 15,color: Colors.green),),
               const SizedBox(height: 5,),
               Text(widget.task.taskName,style:const  TextStyle(fontSize: 20,color: Colors.green),),
             ],
           ),
         ),
              ),
      )
    );
  }

  void delete(BuildContext context){
    widget.action();
    
  }
}
