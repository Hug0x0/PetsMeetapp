import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUserDetails extends StatefulWidget {
  ProfileUserDetails({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _ProfileUserDetailsState createState() => _ProfileUserDetailsState();
}

class _ProfileUserDetailsState extends State<ProfileUserDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Text('Profil'),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: ProfileUserDetailsPage(widget.uid.toString())),
    );
  }
}

class ProfileUserDetailsPage extends StatelessWidget {
  final String uid;

  ProfileUserDetailsPage(this.uid);

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(this.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          List listImages = data["images"];
          return Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          data['imageProfile'],
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "${data['firstName']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.only(right: 20, left: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: AppBar(
                          bottom: TabBar(
                            tabs: [
                              Tab(text: "Description"),
                              Tab(text: "Images (${listImages.length})")
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          _description(data),
                          _image(data),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Text(snapshot.toString());
      },
    );
  }
}

Widget _description(data) {
  return Center(
    child: data["description"] != null
        ? Text("${data["description"]}")
        : Text('Aucune description pour le moment...'),
  );
}

Widget _image(data) {
  List list = data["images"];
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          data['images'][index],
        ),
      );
    },
  );
}
