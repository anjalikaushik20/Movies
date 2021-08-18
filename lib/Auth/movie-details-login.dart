import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/Auth/feed-login.dart';

class MovieDetailLogin extends StatefulWidget {
  final DocumentSnapshot movie;

  MovieDetailLogin({this.movie});
  

  @override
  _MovieDetailLoginState createState() => _MovieDetailLoginState();
}

class _MovieDetailLoginState extends State<MovieDetailLogin> {

  final databaseReference = Firestore.instance;
  int flag = 0;
  //DocumentSnapshot movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'My Movie',
                    style: GoogleFonts.vt323(fontSize: 40),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Divider(thickness: 2, color: Colors.black,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: (){
                      //edit function
                    }, 
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                      ),
                    ),
                  VerticalDivider(),
                  FlatButton(
                    onPressed: (){
                      //delete function
                      _delete();
                    }, 
                    child: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/atricle_back.png"),
                  fit: BoxFit.fill,
                ),
                //border: Border.all(color: Colors.black, width: 5),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height/1.2,
                child: Container(
                    height: MediaQuery.of(context).size.height/1.5,
                    margin:
                        EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 100,),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.movie.data['title'].toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Subway',
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '(by ${widget.movie.data['name']})',
                            style: TextStyle(
                              fontFamily: 'Subway',
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '[${widget.movie.data['occupation']}]',
                            style: TextStyle(
                              fontFamily: 'Chenier',
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Image.asset('assets/images/divider.png'),
                          Text(
                            widget.movie.data['description'],
                            style: TextStyle(
                              fontFamily: 'Chenier',
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _delete() async {
    var uid = widget.movie.documentID;
    await databaseReference.collection("movies").document(uid).delete();

    flag = 1;
    _postDeleted();
  }

  void _postDeleted() {
    if (flag == 1) {
      Fluttertoast.showToast(
        msg: "Post Deleted!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new FeedLogin()),
      );

      flag = 0;
    } else {
      Fluttertoast.showToast(
        msg: "Unable to delete, please try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }
  }
}
