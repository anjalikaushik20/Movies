import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:movies/movie/new-movie.dart';

class AddImage extends StatefulWidget {
  //const AddImage({ Key? key }) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Container(
                //backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                        //borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image,
                          width: 300,
                          height: 300,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                        
                      ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _confirm(_image);
            },
            child: Text(
              'Confirm',
              style: GoogleFonts.vt323(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });

    //_confirm(image);
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });

    //_confirm(image);
  }

  void _confirm(image){
    MovieEntry nm = new MovieEntry();
    Navigator.push(
      context,
      MaterialPageRoute(
            builder: (context) => NewMovie(),
                ),
    );
  }

  //Showpicker
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      );
  }

}