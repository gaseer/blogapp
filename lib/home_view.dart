import 'package:blogui/post.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Blog App",style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
                ),
                
                IconButton(onPressed: () {}, icon: Icon(Icons.account_circle,size: 32,),),
                IconButton(onPressed: () {}, icon: Icon(Icons.add,size: 50,),),
              ],
            ),
          ),
          Expanded(child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Post(),
            );
          },
          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {

      }, label: Row(
      children: [
        Icon(Icons.upload,size: 25,
        ),
        SizedBox(width: 5,),
        Text("Create Blog",style: TextStyle(fontSize: 14),
        ),
      ],
      ),
      ),
    );
  }
}
