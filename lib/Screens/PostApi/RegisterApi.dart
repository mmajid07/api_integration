import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class RegisterApi extends StatefulWidget {
  const RegisterApi({super.key});

  @override
  State<RegisterApi> createState() => _RegisterApiState();
}

class _RegisterApiState extends State<RegisterApi> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void login(String email , password) async{
    try{

      http.Response response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: {
          "email" : email,
          "password" : password,
          }
      );

      var data = jsonDecode(response.body);
      print(data["token"]);

      if(response.statusCode==200){
        print("Login Successfully");
      }else{
        print ("Failed");
      }


    }catch(e){
      print(e.toString());
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter E-Mail",
                  label: Text("E-Mail"),
                ),
              ),
          SizedBox(height: 20),

          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Enter Password",
              label: Text("Password"),
            ),
          ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  login(emailController.text.toString(), passwordController.text.toString());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text("Login")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
