import 'package:flutter/cupertino.dart';

class AppButtons extends StatelessWidget{
  final Color textcolor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  double size;


  AppButtons({super.key,
    required this.textcolor,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.size,});

  @override
  Widget build(BuildContext context){
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
          width: 1.0
        )
      ),
      child: Center(
        child: Text(
          text

        ),
      ),
    );
  }


}