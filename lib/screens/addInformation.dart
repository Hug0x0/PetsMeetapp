import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class AddInformation extends StatefulWidget {
  AddInformation({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _AddInformationState createState() => _AddInformationState();
}

class _AddInformationState extends State<AddInformation> {
  int _currentStep = 0;
  File _imageProfile;
  File _imageAnimalProfile;
  List<Asset> _images = <Asset>[];
  List<File> fileImages = [];
  List<File> fileImagesAnimal = [];
  List<Asset> _imagesAnimal = <Asset>[];
  String _error = 'No Error Dectected';
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _descriptionAnimalController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  _openProfileImage() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _imageProfile = picture;
    });
  }

  _openAnimalProfileImage() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _imageAnimalProfile = picture;
    });
  }

  _openOtherImages() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _images = resultList;
      _error = error;

      resultList.forEach((imageAsset) async {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

        File tempFile = File(filePath);
        if (tempFile.existsSync()) {
          fileImages.add(tempFile);
        }
      });
    });
  }

  _openOtherAnimalImages() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: _imagesAnimal,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _imagesAnimal = resultList;
      _error = error;

      resultList.forEach((imageAsset) async {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

        File tempFile = File(filePath);
        if (tempFile.existsSync()) {
          fileImagesAnimal.add(tempFile);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Pour en savoir plus sur vous",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Stepper(
                    steps: _mySteps(),
                    currentStep: this._currentStep,
                    type: StepperType.horizontal,
                    onStepTapped: (step) {
                      setState(() {
                        this._currentStep = step;
                      });
                    },
                    onStepContinue: () {
                      setState(() {
                        if (this._currentStep < this._mySteps().length - 1) {
                          this._currentStep = this._currentStep + 1;
                          print(widget.uid);
                        } else {
                          print("Checked continue");

                          DocumentReference animal = FirebaseFirestore.instance
                              .collection('animalProfile')
                              .doc(widget.uid);
                          animal.set({
                            'age': _ageController.text,
                            'race': _raceController.text,
                            'name': _nameController.text,
                            'useruid': widget.uid,
                            'description': _descriptionAnimalController.text
                          });

                          DocumentReference users = FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.uid);
                          users.update(
                            {
                              'description': _descriptionController.text,
                            },
                          );

                          //Add image profil of user in users and animalProfile collection
                          String imageUserProfile = _imageProfile.path;
                          FirebaseStorage storageUserProfile =
                              FirebaseStorage.instance;
                          Reference refUserProfile = storageUserProfile
                              .ref()
                              .child("uploads/$imageUserProfile");
                          UploadTask uploadTaskUserProfile =
                              refUserProfile.putFile(_imageProfile);
                          uploadTaskUserProfile.then((res) {
                            res.ref.getDownloadURL().then((value) =>
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.uid)
                                    .update({"imageProfile": value}));
                          });
                          uploadTaskUserProfile.then((res) {
                            res.ref.getDownloadURL().then((value) =>
                                FirebaseFirestore.instance
                                    .collection('animalProfile')
                                    .doc(widget.uid)
                                    .update({"imageProfileUser": value}));
                          });

                          // String imageAnimalProfile = _imageAnimalProfile.path;
                          // storage.ref().child("uploads/$imageAnimalProfile");
                          // ref.putFile(_imageAnimalProfile);
                          // uploadTask.then((res) {
                          //   res.ref.getDownloadURL().then((value) =>
                          //       FirebaseFirestore.instance
                          //           .collection('animalProfile')
                          //           .doc(widget.uid)
                          //           .update({"imageProfile": value}));
                          // });

                          // Add image profil animal in animalProfile collection
                          String imageAnimalProfile = _imageAnimalProfile.path;
                          FirebaseStorage storageAnimalProfile =
                              FirebaseStorage.instance;
                          Reference refAnimalProfile = storageAnimalProfile
                              .ref()
                              .child("uploads/$imageAnimalProfile");
                          UploadTask uploadTaskAnimalProfile =
                              refAnimalProfile.putFile(_imageAnimalProfile);
                          uploadTaskAnimalProfile.then((res) {
                            res.ref.getDownloadURL().then((value) =>
                                FirebaseFirestore.instance
                                    .collection('animalProfile')
                                    .doc(widget.uid)
                                    .update({"imageProfile": value}));
                          });

                          for (var img in fileImages) {
                            print(img.path);
                            FirebaseStorage storageImages =
                                FirebaseStorage.instance;
                            Reference refImages =
                                storageImages.ref().child("uploads/$img");
                            UploadTask uploadTaskImages =
                                refImages.putFile(img);
                            uploadTaskImages.then((res) => {
                                  res.ref.getDownloadURL().then((value) =>
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(widget.uid)
                                          .update({
                                        "images": FieldValue.arrayUnion([value])
                                      }))
                                });
                          }

                          for (var img in fileImagesAnimal) {
                            print(img.path);
                            FirebaseStorage storageImagesAnimal =
                                FirebaseStorage.instance;
                            Reference refImagesAnimal =
                                storageImagesAnimal.ref().child("uploads/$img");
                            UploadTask uploadTaskImagesAnimal =
                                refImagesAnimal.putFile(img);
                            uploadTaskImagesAnimal.then((res) => {
                                  res.ref.getDownloadURL().then((value) =>
                                      FirebaseFirestore.instance
                                          .collection('animalProfile')
                                          .doc(widget.uid)
                                          .update({
                                        "image": FieldValue.arrayUnion([value])
                                      }))
                                });
                          }

                          // FirebaseStorage storageImages = FirebaseStorage.instance;
                          // Reference refImages =storageImages.ref().child("uploads/$_images");
                          // refImages
                          //     .listAll()
                          //     .then((value) => value.items.forEach((element) {
                          //           element.getDownloadURL().then((value) =>
                          //               FirebaseFirestore.instance
                          //                   .collection('users')
                          //                   .doc(widget.uid)
                          //                   .update({'images': value}));
                          //         }));
                        }
                      });

                      // if (_ageController.text != null) {
                      //   Routing.navigateToScreen(context, Routes.Navigation);
                      // }
                    },
                    onStepCancel: () {
                      setState(() {
                        if (this._currentStep > 0) {
                          this._currentStep = this._currentStep - 1;
                        } else {
                          this._currentStep = 0;
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Votre profil'),
        content: _stepOne(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Profil de votre animal'),
        content: _stepTwo(),
        isActive: _currentStep >= 0,
      )
    ];
    return _steps;
  }

  Widget _stepOne() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ajouter une photo de profil !'),
            _imageProfile == null
                ? GestureDetector(
                    onTap: () {
                      _openProfileImage();
                    },
                    child: Icon(
                      Icons.add_a_photo,
                      size: 60,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          _openProfileImage();
                        },
                        child: Image.file(
                          _imageProfile,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 30),
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
                          Tab(text: "Images"),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            hintText: "Ajouter une description de vous..."),
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('Ajouter des photos de vous !'),
                          ),
                          _images.length == 0
                              ? GestureDetector(
                                  onTap: () {
                                    _openOtherImages();
                                  },
                                  child: Icon(
                                    Icons.add_photo_alternate_rounded,
                                    size: 80,
                                  ),
                                )
                              : SizedBox(
                                  width: 300,
                                  height: 200,
                                  child: GridView.count(
                                    crossAxisCount: 1,
                                    scrollDirection: Axis.horizontal,
                                    children:
                                        List.generate(_images.length, (index) {
                                      Asset asset = _images[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            _openOtherImages();
                                          },
                                          child: AssetThumb(
                                            asset: asset,
                                            width: 200,
                                            height: 200,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _stepTwo() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ajouter une photo de profil pour votre animal !'),
            _imageAnimalProfile == null
                ? GestureDetector(
                    onTap: () {
                      _openAnimalProfileImage();
                    },
                    child: Icon(
                      Icons.add_a_photo,
                      size: 60,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          _openAnimalProfileImage();
                        },
                        child: Image.file(
                          _imageAnimalProfile,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 30),
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
                          Tab(text: "Images"),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      TextFormField(
                        controller: _descriptionAnimalController,
                        decoration: InputDecoration(
                            hintText:
                                "On aimerait connaître un peu plus votre animal..."),
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('Ajouter des photos de votre animal !'),
                          ),
                          _imagesAnimal.length == 0
                              ? GestureDetector(
                                  onTap: () {
                                    _openOtherAnimalImages();
                                  },
                                  child: Icon(
                                    Icons.add_photo_alternate_rounded,
                                    size: 80,
                                  ),
                                )
                              : SizedBox(
                                  width: 300,
                                  height: 200,
                                  child: GridView.count(
                                    crossAxisCount: 1,
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        _imagesAnimal.length, (index) {
                                      Asset asset = _imagesAnimal[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            _openOtherAnimalImages();
                                          },
                                          child: AssetThumb(
                                            asset: asset,
                                            width: 200,
                                            height: 200,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Prénom",
                labelStyle:
                    TextStyle(fontSize: 14, color: Colors.grey.shade400),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )),
              ),
            ),
            TextFormField(
              controller: _raceController,
              decoration: InputDecoration(
                labelText: "Race",
                labelStyle:
                    TextStyle(fontSize: 14, color: Colors.grey.shade400),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )),
              ),
            ),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                labelStyle:
                    TextStyle(fontSize: 14, color: Colors.grey.shade400),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )),
              ),
            ),
          ],
        )
      ],
    );
  }
}
