import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;

  const CustomButton({
    Key key,
    @required this.child,
    @required this.color,
    this.borderRadius: 2.0,
    @required this.onPressed,
    this.height: 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey.shade300;
            } else if (states.contains(MaterialState.disabled))
              return Colors.grey;


            return color;
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
        ),
        child: child,
      ),
    );
  }
}
