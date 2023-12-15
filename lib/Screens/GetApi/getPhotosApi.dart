
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetPhotos extends StatefulWidget {
  const GetPhotos({super.key});

  @override
  State<GetPhotos> createState() => _GetPhotosState();
}

class _GetPhotosState extends State<GetPhotos> {

  List<Photos> photosList = [];
  
  Future <List<Photos>> getPhotos()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(var i in data){
        Photos photos= Photos(i["title"], i["url"], i["id"]);
        photosList.add(photos);
      }
    }
    
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context ,AsyncSnapshot<List<Photos>> snapshot){
              if(!snapshot.hasData){
                return Center(child: Text("Data is loading"));
              }
              else{
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context , index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(photosList[index].url.toString()),
                    ),
                    title: Text(photosList[index].id.toString()),
                    subtitle: Text(photosList[index].title.toString()),
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

class Photos{
  String title, url;
  int id;

  Photos(this.title, this.url, this.id);
}
