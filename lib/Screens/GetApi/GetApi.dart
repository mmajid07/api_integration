import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Models/getApiModel.dart';





class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {

  List <ModelClass> postList=[];
  Future <List<ModelClass>> getData () async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    final data =jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(var i in data){
        postList.add(ModelClass.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Api"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context , snapshot){
          if(!snapshot.hasData){
            return Text("Data is Loading");
          }else{
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index){
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(postList[index].title.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(postList[index].id.toString()),
                      ),

                    ],
                  );
                });
          }
        },
      ),
    );
  }
}

