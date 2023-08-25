import 'package:firebase_practice/user/splash_user/splash%20services.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  Splash_Services splash_services = Splash_Services();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash_services.Islogin(BuildContext, context);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Welcome to! ',textAlign: TextAlign.center ,textStyle:const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
                ),
                WavyAnimatedText('Splash Screen',textAlign: TextAlign.center,
                textStyle:const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
