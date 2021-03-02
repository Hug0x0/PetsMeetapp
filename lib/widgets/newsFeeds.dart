import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "news", home: NewsPage());
  }
}

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News Page"),
        ),
        body: GetNews('3ZMmsftcrL9DIdGUB1Hj'));
  }

  void getUser() {}
}

class GetNews extends StatelessWidget {
  final String documentId;

  GetNews(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference strolls =
        FirebaseFirestore.instance.collection('strolls');

    return FutureBuilder<DocumentSnapshot>(
      future: strolls.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Balade proposé par ${data['creator']} ");
        }

        return Text("loading");
      },
    );
  }
}
