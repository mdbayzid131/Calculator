import 'package:flutter/material.dart';




class MyButton extends StatelessWidget {
  final String buttonText;
  final color;
  final textcolor;
  final buttontap;

  const MyButton({Key? key, required this.buttonText, this.color, this.textcolor, this.buttontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:buttontap,
      child: Padding(padding: EdgeInsets.all(0.3),
      child: ClipRRect(
        child: Container(
          color:color,
          child: Center(
            child: Text(buttonText,
            style: TextStyle(
              color:textcolor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
        ),
      ),
      ),


    );
  }
}
