import 'dart:async';
import 'package:firebase_practice/user/login_user.dart';
import 'package:flutter/material.dart';


class Splash_Services{
  void Islogin(BuildContext , context){
    Timer(const Duration(seconds: 9), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }
}