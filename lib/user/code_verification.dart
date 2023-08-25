import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/user/home_screen.dart';
import 'package:firebase_practice/utils/message_utils.dart';
import 'package:firebase_practice/widgtes/botton.dart';
import 'package:flutter/material.dart';
class CodeVerification extends StatefulWidget {
  final VerificationId;
  const CodeVerification({super.key,required this.VerificationId});

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  final codecontroller = TextEditingController();
  bool loading = false;
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Stack(children: [
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
                          SizedBox(height: 25,),
                          TextFormField(
                              controller: codecontroller,
                              decoration:const InputDecoration(
                                hintText: 'code',
                                hintStyle: TextStyle(color: Colors.grey ),
                                prefixIcon: Icon(Icons.code,color: Color(0xff5E17EB),),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'enter code';
                                }else{
                                  return null;
                                }
                              }
                          ),
                          SizedBox(height: 40,),
                          RoundBotton(text: 'verify code', ontap: ()async{
                            if(formkey.currentState!.validate()){
                              setState(() {
                                loading = true;
                              });
                              final credendial = PhoneAuthProvider.credential(
                                verificationId: widget.VerificationId,
                                smsCode: codecontroller.text.toString(),
                              );
                              try{
                                await _Auth.signInWithCredential(credendial);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
                                setState(() {
                                  loading = false;
                                });
                              }catch(e){
                                Utils().toastMessages(e.toString());
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          }, loading: loading)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],),
          ),
        )
      ),
    );

  }
}
