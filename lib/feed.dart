import 'package:movies/movie/movie-details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
//add image to feed
class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  Future _data;

  Future getArticles() async {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection("movies").getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();

    _data = getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.75,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'Feed',
                    style: GoogleFonts.vt323(fontSize: 40),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.75,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Divider(thickness: 2, color: Colors.black,),
            FlatButton(
              onPressed: (){Navigator.pop(context);}, 
              child: Icon(Icons.arrow_back, color:Colors.black)),
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: _data,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                            //  return ListTile(
                            //    title: Text(snapshot.data[index].data['title']),
                            //  );
                              return Container(
                                padding: EdgeInsets.all(5.0),
                                child: Card(
                                  color: Colors.grey[300],
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieDetail(
                                                  movie: snapshot.data[index],
                                                ))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].data['title'],
                                            style:
                                                GoogleFonts.vt323(fontSize: 30),
                                          ),
                                          Text(
                                            '${snapshot.data[index].data['name']} [Director]',
                                            style:
                                                GoogleFonts.vt323(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  elevation: 5,
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
