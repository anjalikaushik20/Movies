import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/dashboard.dart';
import 'package:movies/movie/add-image.dart';
import 'dart:io';

class NewMovie extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieEntry(),
    );
  }
}

class MovieEntry extends StatefulWidget {
  File _image;
  @override
  _MovieEntryState createState() => _MovieEntryState();

  void addImage(_image){
    //
  }
}

class _MovieEntryState extends State<MovieEntry> {
  String name, title, description;
  bool _pressed = false;
  final databaseReference = Firestore.instance;
  int flag = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File _image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[300],
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 4.3,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'New Entry',
                    style: GoogleFonts.vt323(fontSize: 40),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 4.3,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 7),
                    TextField(
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Director\'s name',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      onChanged: (text) {
                        this.name = text;
                      },
                    ),
                    SizedBox(height: 7),
                    TextField(
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Title',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      onChanged: (text) {
                        this.title = text;
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: 50,
                      minLines: 1,
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Your description here! (max 20 words)',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      onChanged: (text) {
                        this.description = text;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add Image",
                      style: GoogleFonts.vt323(fontSize: 25),
                      ),
                    TextButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddImage(),
                            ),
                          ),
                      child: Icon(Icons.image, color: Colors.black),
                      ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        setState(() {
                          _pressed = true;
                          print(_pressed);
                        });
                      },
                      onTapUp: (TapUpDetails details) {
                        setState(() {
                          _pressed = false;
                          print(_pressed);
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _pressed = false;
                          print(_pressed);
                        });
                      },
                      child: TextButton(
                        //highlightColor: Colors.black,
                        onPressed: () {
                          _post();
                        },
                        child: Text(
                          'Post',
                          style: GoogleFonts.vt323(fontSize: 25),
                        ),
                        //textColor: _pressed ? Colors.white : Colors.black,
                        //color: _pressed ? Colors.black : Colors.white,
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () => {Navigator.pop(context)},  //fix this
                    //   child: Icon(Icons.arrow_back, color:Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _post() async {
    await databaseReference.collection("movies").document().setData({
      'description': description,
      'name': name,
      'title': title,
    });

    flag = 1;
    _postSuccess();
  }

  void _postSuccess() {
    if (flag == 1) {
      // Fluttertoast.showToast(
      //   msg: "Posted Successfully!",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      //   fontSize: 12.0,
      // );
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new Dashboard()),
      );

      flag = 0;
    // } else {
    //   Fluttertoast.showToast(
    //     msg: "Unable to post, please try again!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //     fontSize: 12.0,
    //   );
     }
  }

  void addImage(_image){
    //
  }
}
