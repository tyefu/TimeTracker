import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/custom_button.dart';

class SignInButton extends CustomButton{
  SignInButton({
   @required String text,
   @required Color color,
   @required Color textColor,
   @required VoidCallback onPressed,
}) : super(
    child: Text(text,style: TextStyle(color: textColor,fontSize: 16.0),),
    color: color,
    height: 60.0,
    onPressed: onPressed,
  );
}