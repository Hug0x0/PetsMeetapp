import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/button/customButton.dart';

class StrollDetails extends StatefulWidget {
  StrollDetails({Key key, this.strollId}) : super(key: key);

  final String strollId;

  @override
  _StrollDetailsState createState() => _StrollDetailsState();
}

class _StrollDetailsState extends State<StrollDetails> {
  final TextEditingController _modifCreatorController = TextEditingController();
  final TextEditingController _modifDescriptionController =
      TextEditingController();
  final TextEditingController _modifPlaceController = TextEditingController();
  final TextEditingController _modifParticipantsController =
      TextEditingController();
  final TextEditingController _modifDateController = TextEditingController();
  final TextEditingController _modifHourController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool hasClick = false;

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
                            child: Scaffold(
                                appBar: AppBar(
                                  title: Text('Mofifier une balade'),
                                ),
                                body: SingleChildScrollView(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Column(children: <Widget>[
                                        TextFormField(
                                          controller: _modifCreatorController,
                                          decoration: const InputDecoration(
                                              labelText: 'Name'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Veuillez entrer votre nom.';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller:
                                              _modifDescriptionController,
                                          decoration: const InputDecoration(
                                              labelText: 'Description'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Veuillez entrer une description';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller:
                                              _modifParticipantsController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              labelText:
                                                  'Nombre de participants'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Veuillez entrer un nombre de participants';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: _modifPlaceController,
                                          decoration: const InputDecoration(
                                              labelText: 'Place'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Veuillez entrer une ville';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                            controller: _modifDateController,
                                            decoration: InputDecoration(
                                                labelText: "Date"),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Veuillez entrer une date';
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              DateTime date = DateTime.now();

                                              date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2100));
                                              _modifDateController.text =
                                                  getDate(
                                                      date.toString(), date);
                                            }),
                                        TextFormField(
                                            controller: _modifHourController,
                                            decoration: InputDecoration(
                                                labelText: "Heure"),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Veuillez entrer une heure';
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              var time = await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          DateTime.now()));
                                              _modifHourController.text =
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
                                                  if (_modifCreatorController
                                                          .text.isNotEmpty ||
                                                      _modifDescriptionController
                                                          .text.isNotEmpty ||
                                                      _modifParticipantsController
                                                          .text.isNotEmpty ||
                                                      _modifPlaceController
                                                          .text.isNotEmpty) {
                                                    FirebaseFirestore.instance
                                                        .collection('strolls')
                                                        .doc(widget.strollId
                                                            .toString())
                                                        .update({
                                                      'creator':
                                                          _modifCreatorController
                                                              .text,
                                                      'creator_uid':
                                                          _auth.currentUser.uid,
                                                      'date':
                                                          _modifDateController
                                                              .text,
                                                      'description':
                                                          _modifDescriptionController
                                                              .text,
                                                      'hour':
                                                          _modifHourController
                                                              .text,
                                                      'participant':
                                                          _modifParticipantsController
                                                              .text,
                                                      'place':
                                                          _modifPlaceController
                                                              .text,
                                                    });
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
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
                                                    "Modifier une balade",
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
                                ))),
                          ),
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
                  Navigator.pop(context);
                },
              )
            ],
          ),
          body: GetNews(widget.strollId.toString())),
    );
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
                        child: CustomButton('Participer', null),
                      )
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
