import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_practice/user/home_screen.dart';
import 'package:firebase_practice/utils/message_utils.dart';
import 'package:firebase_practice/widgtes/botton.dart';
import 'package:flutter/material.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  bool loading = false;
  final postcontroller = TextEditingController();
  final firebaseref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 45,),
            TextFormField(
              maxLines: 4,
              controller: postcontroller,
              decoration: InputDecoration(
                hintText: 'whats in your mind',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 45,),
            RoundBotton(text: 'Add posts', ontap: (){
              setState(() {
                loading =true;
              });
              String id = DateTime.now().microsecondsSinceEpoch.toString();
              firebaseref.child(id).set({
                'id':id ,
                'title':postcontroller.text.toString(),
              }).then((value){
                setState(() {
                  loading =false;
                });
                Utils().toastMessages('post added');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
              }).onError((error, stackTrace) {
                setState(() {
                  loading =false;
                });
                Utils().toastMessages(error.toString());
              });
            }, loading: loading)
          ],
        ),
      ),
    );
  }
}
