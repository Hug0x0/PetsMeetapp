import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';

class StrollDetails extends StatefulWidget {
  StrollDetails({Key key, this.strollId}) : super(key: key);

  final String strollId;

  @override
  _StrollDetailsState createState() => _StrollDetailsState();
}

class _StrollDetailsState extends State<StrollDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(widget.strollId.toString()),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Routing.navigateToScreen(context, Routes.Navigation);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.mode_edit,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("strolls")
                      .doc(widget.strollId.toString())
                      .delete();
                  Routing.navigateToScreen(context, Routes.Navigation);
                },
              )
            ],
          ),
          body: GetNews(widget.strollId.toString())),
    );
  }
}

class GetNews extends StatelessWidget {
  final String strollId;

  GetNews(this.strollId);

  @override
  Widget build(BuildContext context) {
    CollectionReference strolls =
        FirebaseFirestore.instance.collection('strolls');
    return FutureBuilder<DocumentSnapshot>(
      future: strolls.doc(this.strollId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(
            body: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/calendar.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text("${data['date']}"),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 90),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/participants.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  Text("${data['participants']}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 40, top: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/time.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text("${data['hour']}"),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 55, top: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/person.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text("${data['creator']}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 50,
                        child: Text("${data['description']}"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 150, bottom: 30),
                        height: 20,
                        child: Text("${data['creator']}"),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () {},
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff71afff),
                                  Color(0xff529cfa),
                                  Color(0xff1b7bf5),
                                ],
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                  maxWidth: double.infinity, minHeight: 50),
                              child: Text(
                                "Participer",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Text("loading");
      },
    );
  }
}
