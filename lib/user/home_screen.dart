import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_practice/user/add_post.dart';
import 'package:firebase_practice/user/login_user.dart';
import 'package:firebase_practice/utils/message_utils.dart';
import 'package:flutter/material.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final  FirebaseAuth _Auth = FirebaseAuth.instance;
  bool loading = false;
  final searchcontroller = TextEditingController();
  final ref =FirebaseDatabase.instance.ref('post');
  final editcontroller = TextEditingController();


  Logout(){
    _Auth.signOut().then((value){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace){
      Utils().toastMessages(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5E17EB),
        title: Text('home page') ,
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(child: ListTile(
              leading: Text('Account'),
              trailing: Icon(Icons.person),
            )),
            PopupMenuItem(child: ListTile(
              leading: Text('setting'),
              trailing: Icon(Icons.settings),
            )),
            PopupMenuItem(child: ListTile(
              leading: Text('logout'),
              onTap: (){
                Logout();
              },
              trailing: Icon(Icons.logout),
            ))
          ])
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcontroller,
              decoration: InputDecoration(
                hintText: 'search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Center(child: Text('loading...')),
                itemBuilder: (context,snapshot,animation,index){
                  final title = snapshot.child('title').value.toString();
                  if(searchcontroller.text.isEmpty){
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Image.asset('asset/fb.png',fit: BoxFit.fill,),
                        ),
                        shape: RoundedRectangleBorder(side: BorderSide(width: 2,color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                          itemBuilder: (context)=>[
                            PopupMenuItem(child: ListTile(

                              leading: Icon(Icons.edit),
                              onTap: (){
                                Navigator.pop(context);
                                showmyDialog(title,snapshot.child('id').value.toString());

                              },
                              title: Text('edit'),

                            )),
                            PopupMenuItem(child: ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('delete'),
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                              },
                            ))
                          ],
                        ),
                      ),
                    );
                  }else if(title.toLowerCase().contains(searchcontroller.text.toLowerCase().toLowerCase())){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  }else{
                    return Container();
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosts()));
      },child: Icon(Icons.local_post_office),),
    );
  }
  Future<void> showmyDialog(String title ,String id)async{
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('update'),
        content: Container(
          child: TextFormField(
            controller:editcontroller ,
            decoration: InputDecoration(
              hintText: 'edit here',
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);

          }, child: Text('cancel')),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(id).update({
              'title': editcontroller.text
            }).then((value) {
              Utils().toastMessages('title updated sucessfully');
            }).onError((error, stackTrace){
              Utils().toastMessages(error.toString());
            });
          }, child: Text('update'))
        ],
      );
    });
  }
}
