import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/user/login_user.dart';
import 'package:firebase_practice/user/phone_signup.dart';
import 'package:firebase_practice/widgtes/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/message_utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final  FirebaseAuth _Auth = FirebaseAuth.instance;
  bool obsecureText = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
   Signin(){
    _Auth.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
    ).then((value){
      Utils().toastMessages('registration sucessful');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      setState(() {
        loading =false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessages(error.toString());
      setState(() {
        loading = false;
      });
    });
 }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Form(
        key: formkey,
        child: Scaffold(
          body: Container(
              height: double.infinity,
              width: double.infinity,
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
                        SingleChildScrollView(
                          child: Center(
                            child: Container(
                              height: 350,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black26,blurRadius: 20),
                                  ]
                              ),

                              child: SingleChildScrollView(

                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xff63CAF5),width: 2,strokeAlign: BorderSide.strokeAlignCenter),
                                          color: Color(0xff63CAF5),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight: Radius.circular(20),),


                                      ),
                                      child:InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneSignup()));
                                        },
                                        child: const Row(
                                          mainAxisAlignment:MainAxisAlignment.center ,
                                          children: [
                                            Center(child: Image(image: AssetImage('asset/cr.png'),)),
                                            SizedBox(width: 15,),
                                            Center(child: Text('Continue with phone ',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                                            SizedBox(width: 25,),
                                          ],
                                        ),
                                      ),

                                    ),
                                    SizedBox(height: 25,),
                                    Center(child: Text('----------------------- OR -----------------------')),
                                    SizedBox(height: 15,),
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
                                    SizedBox(height: 15,),
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
                                          },child: Icon(obsecureText?Icons.visibility:Icons.visibility_off,color: Color(0xff5E17EB),)),
                                        ),

                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'enter password';
                                          }else{
                                            return null;
                                          }
                                        }
                                    ),
                                    SizedBox(height: 15,),
                                    TextFormField(
                                      controller: confirmpasswordcontroller,
                                        obscureText: obsecureText,
                                        decoration: InputDecoration(
                                          hintText: 'confirm password',
                                          hintStyle: TextStyle(color: Colors.grey ),
                                          prefixIcon: Icon(Icons.lock,color: Color(0xff5E17EB),),
                                          suffixIcon: GestureDetector(onTap: (){
                                            setState(() {
                                              obsecureText =!obsecureText;
                                            });
                                          },child: Icon(obsecureText?Icons.visibility:Icons.visibility_off,color: Color(0xff5E17EB),))
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'confirm password';
                                          }else{
                                            return null;
                                          }
                                        }
                                    ),
                                    SizedBox(height: 20,),
                                    RoundBotton(text: 'SigIn', ontap: (){
                                      if(formkey.currentState!.validate()){
                                        Signin();
                                        setState(() {
                                          loading = true;
                                        });
                                      }

                                    }, loading: loading),
                                  ],

                                ),
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
                                Text('Already have an account?',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                }, child: Text('Login!',style: TextStyle(color: Color(0xff5E17EB),fontSize: 14,fontWeight: FontWeight.bold))
                                )],
                            ),
                          ),

                        ),

                      ],
                    )
                  ],
                ),
              )
          ),
        ),
  )
    );
  }
}

