import 'package:blogui/BottomNavi/BotttomNavigatorBar.dart';
import 'package:blogui/home/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../other/constants.dart';

class editprofile extends StatefulWidget {
  const editprofile({Key? key, required this.username, required this.about, required this.image})
      : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
  final String username;
  final String about;
  final String image;
}

class _editprofileState extends State<editprofile> {
  String imageUrl='';
  int count=0;
  File? _images;
  final storage=FirebaseStorage.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future getImage(ImageSource source) async {

    final image = await ImagePicker().pickImage(source: source);
    _images=File(image!.path);

    DocumentSnapshot id = await FirebaseFirestore
        .instance
        .collection('settings')
        .doc("settings")
        .get();
    id.reference.update(
        {"userImage": FieldValue.increment(1)});
    var imageId = id['userImage'];

    // Upload to firebase

    var storageReference = await storage.ref().child("Profile/$imageId").putFile(_images!);
    var downloadUrl = await storageReference.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
      FirebaseFirestore.instance.collection('users').doc(CurrentUserID).update(
          {
            'profile':downloadUrl
          });
    });
    if(mounted){
      setState(() {
        _images=File(image.path);
      });
    }
  }

//SaveFilePermanently

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename('asset');
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }

  // Category Section

  List<dynamic> category=[];

  String? categoryId;
  String? categoryData="";
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    _usernameController.text = widget.username;
    _bioController.text = widget.about;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _images != null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(_images!),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              NetworkImage(widget.image),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (buildContext) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    getImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    "assets/icons/picture.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                Text("Camera",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    child: Image.asset(
                                      "assets/icons/picture1.png",
                                      height: 50,
                                      width: 50,
                                    )),
                                Text("Gallery",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      );

                    });
              },
               child:Container(
                 height: 25,
                 width: 78,
                 margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(30),
                   color: kBottomNavBarColor.withOpacity(0.06),
                 ),
                 child: Padding(
                   padding: const EdgeInsets.only(left: 10),
                   child: Row(
                     children: [
                       Text("Edit profile",style: TextStyle(color: Colors.white70),),
                     ],
                   ),
                 ),
               ),
            ),

            // Text("Edit your profile photo",style: TextStyle(color: Colors.blue),),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 35,
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        fillColor: Colors.transparent,
                        filled: true,
                        labelText: 'User Name',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _bioController,
                    keyboardType: TextInputType.multiline,
                    maxLength: 500,
                    maxLines: 10,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        fillColor: Colors.transparent,
                        filled: true,
                        labelText: 'About',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundedLoadingButton(
                    color: Colors.white,
                      controller: RoundedLoadingButtonController(),
                      onPressed: () {
                        Navigator.pop(context);
                        print(CurrentUserID);
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(CurrentUserID)
                            .update({
                          'search':setSearchParam(_usernameController.text),
                          'username': _usernameController.text,
                          'about': _bioController.text,
                        });

                        setState(() {
                          CurrentUserName = _usernameController.text;
                        });

                        RoundedLoadingButtonController().reset();
                      },
                      child: Text('Save',style: TextStyle(
                        color: Colors.black
                      )),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget CustomButton({
  required IconData icon,
  required VoidCallback onclick,
}) {
  return Container(
    width: 100,
    child: ElevatedButton(
      onPressed: onclick,
      child: Column(
        children: [
          Icon(
            icon,
            size: 80,
          ),
        ],
      ),
    ),
  );
}
