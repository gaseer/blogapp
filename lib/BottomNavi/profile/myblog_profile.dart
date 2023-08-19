import 'package:blogui/home/main.dart';
import 'package:blogui/other/constants.dart';
import 'package:blogui/posts/detailed_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../posts/edit_post.dart';



class My_blogs extends StatefulWidget {
  const My_blogs({Key? key}) : super(key: key);

  @override
  State<My_blogs> createState() => _My_blogsState();
}

class _My_blogsState extends State<My_blogs> {
  @override
  Widget build(BuildContext context) {
    var size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Blog"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("posts").where('postedby',isEqualTo: CurrentUserEmail).snapshots(),
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>detailedpost(
                            data[index]["title"],
                            data[index]["description"],
                            data[index]["image"],
                            data[index]['likes'],
                            data[index]['id'],
                            data[index]['postedby']
                        )));
                            // detailedpost( data[index]["title"],  data[index]["description"],data[index]["image"],likes,data[index]['id'],
                            //     data[index]['postedbyProfile'])));
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
                              Text(
                                data[index]["title"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
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
                              color: Colors.white,
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
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (ctx) => Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 190,
                                                            bottom: 490),
                                                        child: AlertDialog(
                                                          actions: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.edit,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Edit_Post(
                                                                                  PostCat: data[index]["category"],
                                                                                  PostImage: data[index]["image"],
                                                                                  PostTitle: data[index]["title"],
                                                                                  PostDiscription: data[index]["description"],
                                                                                  postId: data[index].id,
                                                                                )));
                                                                  },
                                                                  child: Text(
                                                                    "  Edit",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        "Mulish-SemiBold"),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 14,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.delete,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    showDialog(
                                                                      context:
                                                                      context,
                                                                      builder: (ctx) =>
                                                                          AlertDialog(
                                                                            title: const Text(
                                                                                "Delete Post"),
                                                                            content:
                                                                            const Text(
                                                                                "Do you want to delete Post?"),
                                                                            actions: <
                                                                                Widget>[
                                                                              ElevatedButton(
                                                                                  style: ButtonStyle(
                                                                                      backgroundColor: MaterialStatePropertyAll(Colors
                                                                                          .green)),
                                                                                  onPressed:
                                                                                      () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child:
                                                                                  Text('cancel')),
                                                                              ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                    backgroundColor:
                                                                                    MaterialStatePropertyAll(Colors.red)),
                                                                                onPressed:
                                                                                    () {
                                                                                  Navigator.pop(
                                                                                      context);
                                                                                  FirebaseFirestore
                                                                                      .instance
                                                                                      .collection('posts')
                                                                                      .doc(data?[index]['id'])
                                                                                      .delete();
                                                                                },
                                                                                child: const Text(
                                                                                    "okay"),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    "  Delete",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        "Mulish-SemiBold"),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: Container(
                                                    height: 30,width: 30,
                                                      padding: EdgeInsets.only(left: 3,right: 5),
                                                      decoration: BoxDecoration(
                                                        color: kBoxColor.withOpacity(0.9),
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),child: Icon(Icons.more_vert))),
                                            ],
                                          ),

                                          height: 200,
                                          width: 325,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    data[index]["image"]),
                                                fit: BoxFit.fitWidth,
                                              )),
                                        ),

                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1 ,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
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
