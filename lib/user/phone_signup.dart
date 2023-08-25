import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/user/code_verification.dart';
import 'package:firebase_practice/user/signup_user.dart';
import 'package:firebase_practice/utils/message_utils.dart';
import 'package:firebase_practice/widgtes/botton.dart';
import 'package:flutter/material.dart';
class PhoneSignup extends StatefulWidget {
  const PhoneSignup({super.key});

  @override
  State<PhoneSignup> createState() => _PhoneSignupState();
}

class _PhoneSignupState extends State<PhoneSignup> {
  final phonecontroller = TextEditingController();
  bool loading = false;
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();

  @override


  PhoneVerification(){
    _Auth.verifyPhoneNumber(
      phoneNumber:phonecontroller.text ,
        verificationCompleted:(_){
        setState(() {
          loading = false;
        });
        } ,
        verificationFailed: (e){
          Utils().toastMessages(e.toString());
          setState(() {
            loading = false;
          });
        },
        codeSent: (String? VerificationId , int? token){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>CodeVerification(VerificationId: VerificationId)));
        },
        codeAutoRetrievalTimeout: (e){
        Utils().toastMessages(e.toString());
        setState(() {
          loading = false;
        });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key:formkey ,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image(image: AssetImage('asset/bg1.png')),
                Column(
                  children: [
                    SizedBox(height: 70,),
                    Center(child: Text('Instagram',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 50,fontFamily:'Satisfy',fontWeight: FontWeight.bold),)),
                    SizedBox(height: 30,),
                    Container(
                      height: 400,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 10)]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 120,),
                            TextFormField(
                                controller: phonecontroller,
                                decoration:const InputDecoration(
                                  hintText: '+1 343 45465',
                                  hintStyle: TextStyle(color: Colors.grey ),
                                  prefixIcon: Icon(Icons.phone,color: Color(0xff5E17EB),),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'enter phone no.';
                                  }else{
                                    return null;
                                  }
                                }
                            ),
                            SizedBox(height: 50,),
                            RoundBotton(text: 'verify phone number', ontap: (){
                              if(formkey.currentState!.validate()){
                                PhoneVerification();
                                setState(() {
                                  loading = true;
                                });
                              }
                            }, loading: loading),
                            SizedBox(height: 50,),
                            Padding(
                              padding: const EdgeInsets.only(right: 200),
                              child: TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                              }, child: Icon(Icons.arrow_back,size: 30,color: Color(0xff5E17EB),)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}