import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAnimalProfile extends StatefulWidget {
  @override
  _UpdateAnimalProfileState createState() => _UpdateAnimalProfileState();
}

class _UpdateAnimalProfileState extends State<UpdateAnimalProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference animal =
      FirebaseFirestore.instance.collection('animalProfile');
  File _imageProfile;
  bool modifName = false;
  bool modifDescription = false;
  File _otherImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le profil de votre animal'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: animal.doc(this._auth.currentUser.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            List listImages = data["image"];

            return Scaffold(
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _openProfileImage(data);
                          },
                          child: ClipOval(
                            child: Image.network(
                              data['imageProfile'],
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    modifName = !modifName;
                                  });
                                },
                                child: modifName
                                    ? Row(
                                        children: [
                                          SizedBox(
                                              width: 200,
                                              height: 20,
                                              child: TextFormField(
                                                autofocus: true,
                                                onFieldSubmitted: (value) {
                                                  DocumentReference usersName =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'animalProfile')
                                                          .doc(_auth
                                                              .currentUser.uid);
                                                  usersName
                                                      .update({'name': value});
                                                  setState(() {
                                                    modifName = false;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "${data['name']}"),
                                              )),
                                          Icon(Icons.cancel_outlined)
                                        ],
                                      )
                                    : Text(
                                        "${data['name']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          padding: EdgeInsets.only(right: 20, left: 20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        modifDescription = !modifDescription;
                                      });
                                    },
                                    child: Center(
                                      child: modifDescription
                                          ? Column(
                                              children: [
                                                TextFormField(
                                                  onSaved: (value) {
                                                    print(value);
                                                  },
                                                  onFieldSubmitted: (value) {
                                                    DocumentReference
                                                        usersDescription =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'animalProfile')
                                                            .doc(_auth
                                                                .currentUser
                                                                .uid);
                                                    usersDescription.update(
                                                        {'description': value});
                                                    setState(() {
                                                      modifDescription = false;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "${data["description"]}",
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 1,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                ),
                                                Icon(Icons.cancel_outlined)
                                              ],
                                            )
                                          : data["description"] != null
                                              ? Text("${data["description"]}")
                                              : Text(
                                                  'Aucune description pour le moment...'),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listImages.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 300,
                                                    height: 200,
                                                    child: Image.network(
                                                      data['image'][index],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      DocumentReference delete =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'animalProfile')
                                                              .doc(_auth
                                                                  .currentUser
                                                                  .uid);
                                                      delete.update({
                                                        "image": FieldValue
                                                            .arrayRemove(
                                                                listImages)
                                                      });
                                                      setState(() {
                                                        listImages
                                                            .removeAt(index);
                                                      });

                                                      DocumentReference add =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'animalProfile')
                                                              .doc(_auth
                                                                  .currentUser
                                                                  .uid);
                                                      add.update({
                                                        "image": FieldValue
                                                            .arrayUnion(
                                                                listImages)
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.delete_forever,
                                                      size: 40,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          var picture =
                                              await ImagePicker.pickImage(
                                                  source: ImageSource.gallery);
                                          this.setState(() {
                                            _otherImage = picture;

                                            String imagesAnimal =
                                                _otherImage.path;
                                            FirebaseStorage storageOtherImages =
                                                FirebaseStorage.instance;
                                            Reference refOtherImages =
                                                storageOtherImages.ref().child(
                                                    "uploads/$imagesAnimal");
                                            UploadTask uploadTaskAnimalProfile =
                                                refOtherImages
                                                    .putFile(_otherImage);

                                            uploadTaskAnimalProfile.then((res) {
                                              res.ref
                                                  .getDownloadURL()
                                                  .then((value) => setState(() {
                                                        listImages.add(value);
                                                      }));
                                              res.ref.getDownloadURL().then(
                                                  (value) => FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'animalProfile')
                                                          .doc(_auth
                                                              .currentUser.uid)
                                                          .update({
                                                        "image": FieldValue
                                                            .arrayUnion(
                                                                listImages)
                                                      }));
                                            });
                                          });

                                          DocumentReference delete =
                                              FirebaseFirestore.instance
                                                  .collection('animalProfile')
                                                  .doc(_auth.currentUser.uid);
                                          delete.update({
                                            "image": FieldValue.arrayRemove(
                                                listImages)
                                          });

                                          DocumentReference add =
                                              FirebaseFirestore.instance
                                                  .collection('animalProfile')
                                                  .doc(_auth.currentUser.uid);
                                          add.update({
                                            "image": FieldValue.arrayUnion(
                                                listImages)
                                          });
                                        },
                                        child: Icon(
                                          Icons.add_photo_alternate,
                                          size: 60,
                                          color: Colors.lightBlue,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  _openProfileImage(data) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _imageProfile = picture;

      String imageAnimalProfile = _imageProfile.path;
      FirebaseStorage storageAnimalProfile = FirebaseStorage.instance;
      Reference refAnimalProfile =
          storageAnimalProfile.ref().child("uploads/$imageAnimalProfile");
      UploadTask uploadTaskAnimalProfile =
          refAnimalProfile.putFile(_imageProfile);

      uploadTaskAnimalProfile.then((res) {
        res.ref.getDownloadURL().then((value) => setState(() {
              data['imageProfile'] = value;
            }));
        res.ref.getDownloadURL().then((value) => FirebaseFirestore.instance
            .collection('animalProfile')
            .doc(_auth.currentUser.uid)
            .update({"imageProfile": value}));
      });
    });
  }
}
