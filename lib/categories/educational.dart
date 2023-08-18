import 'package:blogui/other/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../posts/detailed_post.dart';
import '../posts/edit_post.dart';

class Educationcat extends StatefulWidget {
  const Educationcat({Key? key}) : super(key: key);

  @override
  State<Educationcat> createState() => _EducationcatState();
}


class _EducationcatState extends State<Educationcat> {
  @override
  Widget build(BuildContext context) {
    var size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Educational"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("posts").where("category",isEqualTo: "Educational").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.docs;
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    List likes = data[index]['likes'];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailedpost(
                                    data[index]["title"],
                                    data[index]["description"],
                                    data[index]["image"],
                                    data[index]['likes'],
                                    data[index]['id'],
                                    data[index]['postedby']
                                )));

                      },
                      child: data[index]["image"] == ''
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  data[index]["title"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore.instance.collection('users').where('email',isEqualTo:data[index]['postedby'] ).snapshots(),
                                                builder: (context, snapshot) {
                                                  if(!snapshot.hasData){
                                                    return CircularProgressIndicator(
                                                      color: kHomeBGColor,
                                                    );
                                                  }
                                                  var postData = snapshot.data?.docs;
                                                  return CircleAvatar(
                                                    backgroundImage:
                                                    NetworkImage(postData?[0]['profile']),
                                                  );
                                                }
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index]['postedbyName'],
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            Text(
                                              data[index]['postedby'],
                                              style: TextStyle(
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 350,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                              Radius.circular(10),
                                              topRight:
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                data[index]["image"]),
                                            fit: BoxFit.fitWidth,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .favorite_outline_rounded,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(likes.length.toString()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data[index]["title"],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: const Text(
                                                  "Report Post"),
                                              content: const Text(
                                                  "Do you want to report Post?"),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors
                                                                .green)),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                    child:
                                                    Text('cancel')),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors
                                                              .red)),
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context);
                                                    FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                        'posts')
                                                        .doc(data?[index]
                                                    ['id'])
                                                        .update({
                                                      'reported': true
                                                    });
                                                  },
                                                  child:
                                                  const Text("okay"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Icon(
                                            Icons.report_gmailerrorred),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}
