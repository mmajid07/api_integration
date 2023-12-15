import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../Models/ComplexModel.dart';

class ComplexApi extends StatefulWidget {
  const ComplexApi({super.key});

  @override
  State<ComplexApi> createState() => _ComplexApiState();
}

class _ComplexApiState extends State<ComplexApi> {

  Future<ComplexModel> getData() async{
    final http.Response response= await http.get(Uri.parse("https://reqres.in/api/users?delay=3"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return ComplexModel.fromJson(data);
    }else{
      return ComplexModel.fromJson(data);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex Api"),
      ),
      body: FutureBuilder<ComplexModel>(
        future: getData(),
        builder: (context,AsyncSnapshot<ComplexModel> snapshot) {
           if(snapshot.hasData){
             return ListView.builder(
                 itemCount: snapshot.data!.data!.length,
                 itemBuilder: (context, index){
                   return Card(
                     child: Column(
                       children: <Widget>[
                         ListTile(
                           leading: CircleAvatar(
                             backgroundImage: NetworkImage(
                               snapshot.data!.data![index].avatar.toString()
                             ),
                           ),
                           title: Text(snapshot.data!.data![index].firstName.toString()),
                           subtitle: Text(snapshot.data!.data![index].email.toString()),
                         )

                       ],
                     ),

                   );
                 });
           }else if(snapshot.hasError){
             return Center(child: Text("Error: ${snapshot.error}"));
           }else{
             return Center(child: CircularProgressIndicator());
           }
          }

      ),
    );
  }
}
