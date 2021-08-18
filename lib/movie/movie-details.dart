import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetail extends StatefulWidget {
  final DocumentSnapshot movie;

  MovieDetail({this.movie});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
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
                    'Movie',
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
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                              fontSize: 35,
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
                              fontSize: 25,
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
}
