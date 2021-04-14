import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pets_meet/screens/profileDetails.dart';
import 'package:pets_meet/screens/strollDetails.dart';

// RECUP TT LES IDS
// final strollsRef = FirebaseFirestore.instance.collection('strolls');
final databaseReference = FirebaseFirestore.instance;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _Home();
  }
}

class _Home extends State<Home> {
  final TextEditingController _creatorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool hasClick = false;

//  FUNCTION POUR AFFICHER LES IDS DE TOUTES LES BALADES
  //   @override
  // void initState() {
  //   getStrolls();
  //   super.initState();
  // }
  //  FUNCTION POUR AFFICHER LES IDS DE TOUTES LES BALADES
  //   getStrolls() {
  //   strollsRef.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print(doc.id);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            bottom: TabBar(
              tabs: [Tab(text: "Profils"), Tab(text: "Balades")],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _listOfProfile(),
            _listOfStroll(),
          ],
        ),
      ),
    )));
  }

  Widget _listOfStroll() {
    return Column(
      children: [
        Flexible(
          flex: 6,
          child: StreamBuilder<QuerySnapshot>(
              stream: databaseReference.collection('strolls').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                      children: documents
                          .map((doc) => Card(
                                child: ListTile(
                                  title: Text(doc['creator']),
                                  subtitle: Text(doc['description']),
                                  onTap: () {
                                    print(doc.id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StrollDetails(
                                                  strollId: doc.id,
                                                )));
                                  },
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text('Bug#1');
                }
                return CircularProgressIndicator();
              }),
        ),
        Flexible(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(left: 300),
            child: FloatingActionButton(
              onPressed: () {
                return showGeneralDialog(
                  barrierLabel: "Barrier",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 700),
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        height: 600,
                        child: SizedBox.expand(
                            child: Form(
                          key: _formKey,
                          child: Scaffold(
                              appBar: AppBar(
                                title: Text('Créer une balade'),
                              ),
                              body: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Form(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Column(children: <Widget>[
                                      TextFormField(
                                        controller: _creatorController,
                                        decoration: const InputDecoration(
                                          labelText: 'Nom',
                                        ),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Veuillez entrer votre nom.';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _descriptionController,
                                        decoration: const InputDecoration(
                                            labelText: 'Description'),
                                        validator: (String value) {
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _participantsController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Nombre de participants'),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Veuillez entrer un nombre de participants';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _placeController,
                                        decoration: const InputDecoration(
                                            labelText: 'Place'),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Veuillez entrer une ville';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                          controller: _dateController,
                                          decoration: InputDecoration(
                                              labelText: "Date"),
                                          onTap: () async {
                                            DateTime date = DateTime.now();

                                            date = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2100));
                                            _dateController.text =
                                                getDate(date.toString(), date);
                                          }),
                                      TextFormField(
                                          controller: _hourController,
                                          decoration: InputDecoration(
                                              labelText: "Heure"),
                                          onTap: () async {
                                            var time = await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        DateTime.now()));
                                            _hourController.text =
                                                //time.format(context);
                                                "${time.hour}:${time.minute}";
                                          }),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        alignment: Alignment.center,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: FlatButton(
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                hasClick = true;
                                                if (_creatorController
                                                        .text.isNotEmpty ||
                                                    _descriptionController
                                                        .text.isNotEmpty ||
                                                    _participantsController
                                                        .text.isNotEmpty ||
                                                    _placeController
                                                        .text.isNotEmpty) {
                                                  createScroll(
                                                      _auth.currentUser.uid,
                                                      _creatorController.text,
                                                      _descriptionController
                                                          .text,
                                                      _participantsController
                                                          .text,
                                                      _placeController.text,
                                                      _dateController.text,
                                                      _hourController.text);
                                                }
                                              }
                                            },
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                                    maxWidth: double.infinity,
                                                    minHeight: 50),
                                                child: Text(
                                                  "Créer une balade",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              )),
                        )),
                        margin:
                            EdgeInsets.only(bottom: 50, left: 12, right: 12),
                      ),
                    );
                  },
                  transitionBuilder: (_, anim, __, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                          .animate(anim),
                      child: child,
                    );
                  },
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _listOfProfile() {
    return Column(
      children: [
        Flexible(
          flex: 6,
          child: StreamBuilder<QuerySnapshot>(
              stream: databaseReference.collection('animalProfile').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                      children: documents
                          .map((doc) => Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(doc['imageProfile'])),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(doc['name']),
                                      Text(doc['race'])
                                    ],
                                  ),
                                  subtitle:
                                      Text(doc['age'].toString() + " ans"),
                                  onTap: () {
                                    print(doc.id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileDetails(
                                                  profileId: doc.id,
                                                  name: doc['name'].toString(),
                                                )));
                                  },
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text('Bug#1');
                }
                return CircularProgressIndicator();
              }),
        ),
      ],
    );
  }

  Future<void> createScroll(String uid, String creator, String description,
      String participants, String place, String date, String hour) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('strolls');
    users.add({
      'creator_uid': uid,
      'creator': creator,
      'description': description,
      'place': place,
      'participants': participants,
      'date': date,
      'hour': hour
    });
    return;
  }

  getStrollId() {
    CollectionReference strolls =
        FirebaseFirestore.instance.collection('strolls');
    return strolls.doc();
  }

  getDate(String date, DateTime selected) {
    String date = DateFormat('dd-MM-yyyy').format(selected);
    return date;
  }

  getHour(String hour, DateTime selected) {
    String hour = DateFormat('kk:mm').format(selected);
    return hour;
  }
}
