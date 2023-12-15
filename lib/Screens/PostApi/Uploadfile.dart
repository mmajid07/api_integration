
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {

  File? image;
  final _picker=ImagePicker();
  bool showSpinner=false;
  
  Future getImage() async{
    final pickedFile= await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(pickedFile!=null){
      image =File(pickedFile!.path);
      setState(() {

      });

    }else{
      print("Image would not be selected");
    }
  }
  
  Future <void> imageUpload() async{
    setState(() {
      showSpinner=true;
    });

    var stream= new http.ByteStream(image!.openRead());
    stream.cast();

    var length= await image!.length();
    
    var uri= Uri.parse("https://fakestoreapi.com/products");
    var request= http.MultipartRequest("POST", uri);
     request.fields["title"]= "Static title";

     var multipart= http.MultipartFile("image", stream, length);

     request.files.add(multipart);

     var response = await request.send();

     if(response.statusCode==200){
       print("Image Uploaded Successfully");
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
        appBar: AppBar(
          title: Text("Upload File"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image== null? Center(child: Text("Pick Image"))
                    :
                Container(
                  child: Center(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
              ),
            ),
            SizedBox(height: 150,),

            GestureDetector(
              onTap: (){imageUpload();},
              child: Container(
                
                height: 70,
                
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text("Upload Image")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
