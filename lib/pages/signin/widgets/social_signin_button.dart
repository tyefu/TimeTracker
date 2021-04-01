import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/custom_button.dart';

class SocialSignInButton extends CustomButton{
  SocialSignInButton({
   @required String assetName,

    @required String text,
    @required Color color,
    @required Color textColor,
    @required VoidCallback onPressed,
  }) : assert(text != null),
        super(
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(assetName),
        Text(text,style: TextStyle(color: textColor),),
        Opacity(opacity: 0.0,child: Image.asset(assetName)),
      ],
    ),
    color: color,
    height: 60.0,
    onPressed: onPressed,
  );
}