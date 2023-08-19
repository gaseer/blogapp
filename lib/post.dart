import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 150,
          width: 160,
          child: Column(
            children: [
              Container(
                height: 90,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight:  Radius.circular(10),topLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(image: AssetImage("assets/images/Image2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Text("Blog Title",overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
