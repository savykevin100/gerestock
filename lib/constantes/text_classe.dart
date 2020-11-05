import 'package:flutter/material.dart';


class TextClasse extends StatefulWidget {
  String text;
  Color color;
  String family;
  double fontSize;
  TextAlign textAlign;
  FontWeight fontWeight;
  int maxLines;


  TextClasse({this.text, this.color, this.family, this.fontSize, this.textAlign, this.fontWeight, this.maxLines});

  @override
  _TextClasseState createState() => _TextClasseState();
}

class _TextClasseState extends State<TextClasse> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text, textAlign: widget.textAlign, maxLines: widget.maxLines,style: TextStyle(color: widget.color, fontSize: widget.fontSize, fontFamily: widget.family, fontWeight: widget.fontWeight),);
  }
}
