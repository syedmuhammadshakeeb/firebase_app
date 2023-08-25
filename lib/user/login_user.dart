import 'package:firebase_practice/widgtes/botton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/user/signup_user.dart';
import 'package:firebase_practice/utils/message_utils.dart';


import 'home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final  FirebaseAuth _Auth = FirebaseAuth.instance;
  bool obsecureText = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  islogin(){
    _Auth.signInWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    ).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace){
      Utils().toastMessages(error.toString());
      setState(() {
        loading = false;
      });
    } );
  }

  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Image(image: AssetImage('asset/bg1.png'),fit: BoxFit.fill,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70,),
                      Center(child: Text('Instagram',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 50,fontFamily:'Satisfy',fontWeight: FontWeight.bold),)),
                      SizedBox(height: 40,),
                      Center(
                        child: Container(
                          height: 350,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black26,blurRadius: 10),
                              ]
                          ),

                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: double.infinity,

                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2,strokeAlign: BorderSide.strokeAlignCenter,color: Colors.blueAccent),
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight: Radius.circular(20),),


                                  ),
                                  child:InkWell(
                                    onTap: (){},
                                    child: const Row(
                                      mainAxisAlignment:MainAxisAlignment.center ,
                                      children: [
                                        Center(child: Image(image: AssetImage('asset/fb.png'),)),
                                        SizedBox(width: 15,),
                                        Center(child: Text('Continue with facebook',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                                        SizedBox(width: 30,),
                                      ],
                                    ),
                                  ),

                                ),
                                SizedBox(height: 25,),
                                Center(child: Text('----------------------- OR -----------------------')),
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: emailcontroller,
                                    decoration:const InputDecoration(
                                      hintText: 'email',
                                      hintStyle: TextStyle(color: Colors.grey ),
                                      prefixIcon: Icon(Icons.person,color: Color(0xff5E17EB),),
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'enter email';
                                      }else{
                                        return null;
                                      }
                                    }
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: passwordcontroller,
                                    obscureText: obsecureText,
                                    decoration: InputDecoration(
                                        hintText: 'password',
                                        hintStyle: TextStyle(color: Colors.grey  ),
                                        prefixIcon: Icon(Icons.lock,color: Color(0xff5E17EB),),
                                      suffixIcon: GestureDetector(onTap: (){
                                        setState(() {
                                          obsecureText =!obsecureText;
                                        });
                                      },
                                        child:Icon(obsecureText?Icons.visibility:Icons.visibility_off,color: Color(0xff5E17EB),) ,)

                                    ),

                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'enter password';
                                      }else{
                                        return null;
                                      }
                                    }
                                ),
                                SizedBox(height: 40,),
                                RoundBotton(text: 'login', ontap: (){
                                  if(formkey.currentState!.validate()){
                                    islogin();
                                    setState(() {
                                      loading = true;
                                    });
                                  }

                                }, loading: loading),
                                SizedBox(height: 10,),
                                TextButton(onPressed: (){}, child: Center(child: Text('Forget password?',style: TextStyle(color: Color(0xff5E17EB),fontWeight: FontWeight.bold),)))
                              ],

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black26 ,blurRadius: 10)
                            ]
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Do you want to register?',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                              }, child: Text('register!',style: TextStyle(color: Color(0xff5E17EB),fontSize: 14,fontWeight: FontWeight.bold))
                              )],
                          ),
                        ),

                      )

                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
