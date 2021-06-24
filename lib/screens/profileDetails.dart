import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/screens/chat.dart';

class ProfileDetails extends StatefulWidget {
  ProfileDetails({Key key, this.profileId, this.name}) : super(key: key);

  final String profileId;
  final String name;

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Text(widget.name.toString()),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: ProfileDetailsPage(widget.profileId.toString())),
    );
  }
}

class ProfileDetailsPage extends StatelessWidget {
  final String profileId;

  ProfileDetailsPage(this.profileId);

  @override
  Widget build(BuildContext context) {
    CollectionReference profile =
        FirebaseFirestore.instance.collection('animalProfile');

    return FutureBuilder<DocumentSnapshot>(
      future: profile.doc(this.profileId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          final user = FirebaseFirestore.instance
              .collection("users")
              .doc(data['useruid'])
              .get();

          Map<String, dynamic> userData = snapshot.data.data();
          List list = data["image"];
          return Scaffold(
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, right: 60, bottom: 20),
                      child: IconButton(
                        icon: Icon(
                          Icons.message_outlined,
                          color: Colors.blue,
                          size: 40,
                        ),
                        onPressed: () {
                          print(data['useruid']);
                          print(FirebaseFirestore.instance
                              .collection("users")
                              .doc(data['useruid'])
                              .get());

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Chat(
                          //         userId: data['useruid'],
                          //         userFirstname: doc['firstName'],
                          //         userLastname: doc['lastName'],
                          //       ),
                          //     ));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "${data['name']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 40, top: 20),
                      child: Column(
                        children: [
                          Text("Possédé par"),
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              data['imageProfileUser'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
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
                              Tab(text: "Images (${list.length})")
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
        return Text("loading");
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
  List list = data["image"];
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          data['image'][index],
        ),
      );
    },
  );
}
