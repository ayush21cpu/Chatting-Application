import 'package:flutter/material.dart';

ButtonStyle btnShape(var cl){
  return ElevatedButton.styleFrom(
    backgroundColor: cl,
    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
  );
}

// ignore: camel_case_types
class btn extends StatelessWidget {
  const btn({super.key,
    required this.colour,required this.onPressed,required this.title,
  });
  final Color colour;
  final VoidCallback onPressed;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ElevatedButton(
        style: btnShape(colour),
        onPressed: onPressed,
        child: Text(title),),
    );
  }
}
