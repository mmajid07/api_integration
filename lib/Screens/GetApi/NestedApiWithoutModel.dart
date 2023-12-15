import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class NestedApiWithoutModel extends StatefulWidget {
  const NestedApiWithoutModel({super.key});

  

  @override
  State<NestedApiWithoutModel> createState() => _NestedApiWithoutModelState();
}

class _NestedApiWithoutModelState extends State<NestedApiWithoutModel> {

  var data;
  Future<void> getData() async{
    final http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode==200){
      data =jsonDecode(response.body.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nested Api with out Model"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context , snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Text("Data Loading");
          }else{
            return  ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
              return Card(
                child: Column(
                  children: [
                    ReUseRow(name: "Name", value: data[index]["name"].toString()),
                    ReUseRow(name: "User Name", value: data[index]["username"].toString()),
                    ReUseRow(name: "Lat", value: data[index]["address"]["geo"]["lat"].toString()),

                  ],
                ),
              );
            });
          }
        },
      ),
    );
  }
}

class ReUseRow extends StatelessWidget {
  String name, value;
   ReUseRow({super.key , required this.name , required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(value),
        ],

      ),
    );
  }
}

