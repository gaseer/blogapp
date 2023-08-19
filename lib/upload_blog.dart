import 'package:blogui/widget/custom_button.dart';
import 'package:blogui/widget/reusable_textfield.dart';
import 'package:flutter/material.dart';
class UploadBlogView extends StatelessWidget {
  const UploadBlogView({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Create Blog'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 20),
                    ReusableTextField(hintText: "Title", controller: TextEditingController(), isMultiline: false),
                    SizedBox(height: 15,),
                    ReusableTextField(hintText: "Description", controller: TextEditingController(), isMultiline: true),
                    Container(
                      height: 145,
                      width: 145,
                      alignment: Alignment.center,
                      child: CustomButton(function: () {}, title: "Upload Image"),
                    ),
                    Container(
                      height: 155,
                      width: 155,
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(function: () {}, title: "Create Blog"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ),
    );
  }
}
