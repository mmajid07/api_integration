import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class fileUp extends StatefulWidget {
  const fileUp({super.key});

  @override
  State<fileUp> createState() => _fileUpState();
}

class _fileUpState extends State<fileUp> {

  File? image;
  final _picker=ImagePicker();
  bool showSpinner=false;


  Future getImage() async{
    final pickedFille= await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(pickedFille!=null){
      image=File(pickedFille.path);
      setState(() {

      });
    }else{
      print("Please Pick Image");
    }
  }

  Future <void> UpFile() async{
    setState(() {
      showSpinner=true;
    });

    var stream= new http.ByteStream(image!.openRead());
    stream.cast();
    
    var length= await image!.length();
    


    var request= http.MultipartRequest("POST", Uri.parse("https://fakestoreapi.com/products"));
    request.fields["title"] = 'Static title';

    var  multipart=http.MultipartFile("image", stream, length);

    request.files.add(multipart);

    var response= await request.send();

    if(response.statusCode==200){
      print("File Upload Successfully");
      setState(() {
        showSpinner=false;
      });
    }else{
      print("Failed");
      setState(() {
        showSpinner=false;
      });
    }



  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){getImage();},
              child: Center(
                child: Container(

                  child: image==null? Center(child: Text("Pick Image"),) :
                      Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                ),
              ),
            ),

            SizedBox(height: 50,),

            GestureDetector(
              onTap: (){UpFile();},
              child: Container(
                height: 70,
                width: 250,
                color: Colors.green,
                child: Center(child: Text("Upload")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
