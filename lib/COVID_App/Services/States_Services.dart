import 'dart:convert';

import 'package:api_integration/COVID_App/Services/Utilities/App_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../AppModels/WorldStatesModel.dart';


class StatesServices{

  Future <WorldStatesModel> fetchWorldStatesRecords() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }

  Future <List<dynamic>> fetchCountriesList() async{
    var data;
    final response= await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Error");
    }
  }



}