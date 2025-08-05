import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:background_remover/background_remover.dart';
import 'package:image_picker/image_picker.dart';



class AddApparelScreen extends StatefulWidget {
  const AddApparelScreen({super.key});
  @override
  State<AddApparelScreen> createState() => _AddApparelScreenState();
}

class _AddApparelScreenState extends State<AddApparelScreen>{
  File? _image;
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Add New Apparel'),
      backgroundColor: Color(0xFFFFCC33),
    ),
    body:
    Positioned(
      child:FloatingActionButton(
        backgroundColor: const Color(0xFFF75A5A),
        child: const Icon(Icons.add, color: Colors.white),

        onPressed: () {
          _openImagePicker(context: context);},
      ),)
    ,
  );
}

Future<void> getImage(ImageSource source) async{

  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source:source);
  if(pickedImage!=null){
    setState((){
      _image = File(pickedImage.path);
    });
  }
}
void _openImagePicker({required BuildContext context,}){
  showModalBottomSheet(
      context:context,
      builder: (BuildContext context){
        return SafeArea(child:Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap:(){
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap:(){
                    getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  })
            ]
        ));
      }
  );
}
}
