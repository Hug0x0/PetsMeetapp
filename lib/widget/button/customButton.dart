import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback function;

  CustomButton(this.name, this.function);

  @override
  Widget build(BuildContext context) {
    return (FlatButton(
      onPressed: function,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff71afff),
              Color(0xff529cfa),
              Color(0xff1b7bf5),
            ],
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 50, maxWidth: double.infinity),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ));
  }
}
