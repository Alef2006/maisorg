import 'package:flutter/material.dart';
import 'package:mais_org/components/card_List.dart';
import 'package:mais_org/entities/task.dart';
import 'package:mais_org/repositories/tasks_repository.dart';

class PageTasksList extends StatefulWidget {
  const PageTasksList({super.key});

  @override
  State<PageTasksList> createState() => _PageTasksListState();
}

class _PageTasksListState extends State<PageTasksList> {


  
  final TasksRepository tasksRepository=TasksRepository();
  final TextEditingController novaTarefaController = TextEditingController();

  List<Task> tasks = [];
  String? errorText;


  @override
  void initState() {
    super.initState();
    tasksRepository.getTasksList().then((value){
            setState(() {
              tasks=value;
            });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: const Image(
              //'assets/images/lista_vazia_sem_fundo.png'
              //'assets/images/ic_launcher_foreground.png'
              image: AssetImage('assets/images/ic_launcher_foreground.png')),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Para fazer",
                style: TextStyle(color: Colors.green, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.green),
                      controller: novaTarefaController,
                      decoration: InputDecoration(
                        errorText:errorText ,
                          hintStyle: const TextStyle(color: Colors.green),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          labelStyle: const TextStyle(color: Colors.green),
                          floatingLabelStyle: const TextStyle(color: Colors.green),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 116, 180, 118))),
                          labelText: "Nova tarefa"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: const WidgetStatePropertyAll(
                              Color.fromARGB(255, 42, 42, 42)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)))),
                      onPressed: addTask,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 18),
                        child: Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.green,
                        ),
                      )),
                ],
              ),
             
              const SizedBox(
                height: 10,
              ),
              Builder(builder: (context) {
                if (tasks.isEmpty) {
                  return Expanded(
                    child: Container(
                     
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/lista_vazia_sem_fundo.png'))),
                    ),
                  );
                }else{
                       return Expanded(
                         child: Flexible(
                           child: ListView(
                            // shrinkWrap: true,
                              children: [
                             for (Task tasking in tasks)
                               Cardlist(
                                 task: tasking,
                                 action:(){
                                   delete(tasking);
                                 },
                               )
                           ]),
                         ),
                       );
                }
                
              }),
              const SizedBox(
                height: 10,
              ),
              Row(
                verticalDirection: VerticalDirection.down,
                children: [
                  Expanded(
                    child: Builder(builder: (BuildContext context) {
                      if (tasks.isEmpty) {
                        return const Text(
                          "Sem tarefas pendentes",
                          style: TextStyle(color: Colors.green),
                        );
                      } else {
                        return Text(
                          "Você possui ${tasks.length} tarefas pendentes",
                          style: const TextStyle(color: Colors.green),
                        );
                      }
                    }),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 42, 42),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: showDialogConfirmationClearTasks,
                      child: const Text(
                        "Limpar tudo",
                        style: TextStyle(color: Colors.green),
                      )),
                ],
              )
            ],
          ),
        ));
  }

  addTask() {
    if (novaTarefaController.text.isEmpty) {
     //alertDialogEscrevaAlgoNoCampo();
     setState(() {
       errorText="Digite algo para adicionar a tarefa.";
     });
     
    }else{
        setState(() {
          errorText=null;

        tasks.add(Task(
            taskName: novaTarefaController.text,
            data:
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : "${DateTime.now().minute}"} "));
        novaTarefaController.clear();
        tasksRepository.saveTasksList(tasks);
      });
    }
  }

  delete(Task task) {
    setState(() {
      tasks.remove(task);
      //tasksRepository.saveTasksList(tasks);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor:const Color.fromARGB(255, 42, 42, 42) ,
      content:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
         const  Text("A tarefa  foi deletada",
          style: TextStyle(color: Colors.green,fontSize: 18),
          ),
          TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                 Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: (){
                          setState(() {
                            tasks.add(task);
                            tasksRepository.saveTasksList(tasks);
                            ScaffoldMessenger.of(context).clearSnackBars();
                          });
                        },
                        child: const Text(
                          "Desfazer",
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        )),
          
        ],
            ),
      ) ));
  }
  
  showDialogConfirmationClearTasks(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      backgroundColor: const Color.fromARGB(255, 38, 38, 38),
      title: const Text("Limpar tudo?",style:TextStyle(color: Colors.green),),
      content: const Text("Você tem certeza que deseja apagar todas as tarefas?",style:TextStyle(color: Colors.green),),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text("Cancelar",style:TextStyle(color: Colors.green),)),
        TextButton(onPressed: (){
          setState(() {
          tasks.clear();
         tasksRepository.saveTasksList(tasks);
          });
          Navigator.of(context).pop();
        }, child: const Text("Limpar tudo",style:TextStyle(color: Colors.red),))

      ],
    ));
  }

 alertDialogEscrevaAlgoNoCampo(){
  showDialog(context: context, builder: (context)=>AlertDialog(
      backgroundColor: const Color.fromARGB(255, 38, 38, 38),
      title: const Text("Campo de texto vazio",style:TextStyle(color: Colors.red),),
      content: const Text("Campo de texto vazio,digite algo no campo 'Nova tarefa'.",style:TextStyle(color: Colors.red),),
      actions: [
        
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text("Ok",style:TextStyle(color: Colors.green),))

      ],
    ));
 }



}
