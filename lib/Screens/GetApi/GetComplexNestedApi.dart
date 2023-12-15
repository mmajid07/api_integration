 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Models/NestedModel.dart';

class NestedApi extends StatefulWidget {
  const NestedApi({super.key});

  @override
  State<NestedApi> createState() => _NestedApiState();
}

class _NestedApiState extends State<NestedApi> {


  List<NestedModel> nestedList=[];


  Future <List<NestedModel>> getNested() async{
    final http.Response response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){

      for(var i in data){
        nestedList.add(NestedModel.fromJson(i));
      }
    }else {
      return nestedList;
    }
    return nestedList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Nested Api"),
      ),
       body: Column(
         children: [
           Expanded(
             child: FutureBuilder(
                 future: getNested(),
                 builder: (context , snapshot){
               if(!snapshot.hasData){
                 return CircularProgressIndicator();
               }else{
                 return ListView.builder(
                     itemCount: nestedList.length,
                     itemBuilder: (context , index){
                   return Card(
                     child: Column(
                       children: [
                         reusableRow(name: "Name :", value: nestedList[index].name.toString()),
                         reusableRow(name: "User Name :", value: nestedList[index].username.toString()),
                         reusableRow(name: "E-Mail :", value: nestedList[index].email.toString()),
                         reusableRow(name: "Address", value: nestedList[index].address!.geo!.lat.toString()),
                       ],
                     ),
                   );
                 });
               }
             }),
           )
         ],
       ),
    );
  }
}

class reusableRow extends StatelessWidget {
  String name, value;
  reusableRow({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(name),
          Text(value),
        ],
      ),
    );
  }
}

