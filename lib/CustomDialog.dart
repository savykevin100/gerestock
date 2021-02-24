import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constantes/hexadecimal.dart';

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  static String id = 'CustomDialog';
  final String title, description, buttonText;
  final Image image;
  Widget cancelButton;
  Widget nextButton;
  Icon icon;

  CustomDialog({
    this.title,
    this.description,
    this.buttonText,
    this.cancelButton,
    this.nextButton,
    this.icon,
    this.image,

  });

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: HexColor("#001C36"),
                  fontFamily: "MonseraBold",
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: HexColor("#001C36"),
                  fontFamily: "MonseraRegular",
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: cancelButton,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: nextButton,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: HexColor('#FFC30D'),
            radius: Consts.avatarRadius,
            child: icon,
          ),
        ),
      ],
    );
  }

  @override
    Widget build(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      );

  }

}




class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
