



class Task{

  Task({required  this.taskName,required this.data});

  Task.fromJson(Map<String,dynamic> json):taskName=json['taskName'],data=json['data'];
   
  

  String taskName;
  String data;

  Map<String,dynamic> toJson(){
    return {
      'taskName':taskName,
      'data':data,
    };
  }

  
  
    
}