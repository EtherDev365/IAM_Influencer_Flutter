import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onclick;
  const GradientButton({Key key, this.text, this.onclick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      child: Container(
        height: 35.0,
        width: 105.0,
        decoration: BoxDecoration(
            gradient: kLinearGradient,
            borderRadius: BorderRadius.all(Radius.circular(100.0))),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: kBackgoundColor, fontSize: 14.0),
        ),
      ),
      onPressed: onclick,
    );
  }
}
