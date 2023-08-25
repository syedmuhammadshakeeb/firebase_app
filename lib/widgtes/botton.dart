import 'package:flutter/material.dart';
class RoundBotton extends StatelessWidget {
  final text;
  final VoidCallback ontap;
  bool loading;

   RoundBotton({
    super.key,
    required this.text,
    required this.ontap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: Color(0xff5E17EB),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xff5E17EB)),
        ),
        child: Stack(
          children: [
            Center(child: loading?CircularProgressIndicator(strokeWidth: 2,color: Colors.white,):Text(text,style:TextStyle(color: Colors.white,fontSize: 16))),
          ],
        )
      ),
    );
  }
}
