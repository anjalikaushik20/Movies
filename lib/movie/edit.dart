import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/Auth/feed-login.dart';

// class EditMovie extends StatelessWidget {

//   final DocumentSnapshot movie;
//   EditMovie({this.movie});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: EditEntry(),
//     );
//   }
// }

class EditEntry extends StatefulWidget {
  final DocumentSnapshot movie;
   EditEntry({this.movie});
   
  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  String name, title, description;
  bool _pressed = false;
  final databaseReference = Firestore.instance;
  int flag = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                    'Edit Entry',
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
                      controller: TextEditingController(
                        text: '${widget.movie.data['name']}',
                        ),
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        //hintText: '${widget.movie.data['name']}',
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
                      controller: TextEditingController(
                        text: '${widget.movie.data['title']}',
                        ),
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        //hintText: '${widget.movie.data['title']}',
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
                      controller: TextEditingController(
                        text: '${widget.movie.data['description']}',
                        ),
                      maxLines: 50,
                      minLines: 1,
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        //hintText: '${widget.movie.data['description']}',
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
                          'Confirm',
                          style: GoogleFonts.vt323(fontSize: 25, color: Colors.black),
                        ),
                      ),
                    ),
                    Text("Note: Kindly edit all three entries to prevent erros!",
                      style: GoogleFonts.vt323(fontSize: 15),),
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
    await databaseReference.collection("movies").document(widget.movie.documentID).updateData({
      'description': description,//widget.movie.data['description'] + description,
      'name': name,//widget.movie.data['name'] + name,
      'title': title,//widget.movie.data['title'] + title,
    });

    flag = 1;
    _postSuccess();
  }

  void _postSuccess() {
    if (flag == 1) {
      // Fluttertoast.showToast(
      //   msg: "Edited Successfully!",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      //   fontSize: 12.0,
      // );
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new FeedLogin()),
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
}
