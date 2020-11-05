import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:hexcolor/hexcolor.dart';

class Sorties extends StatefulWidget {
  @override
  _SortiesState createState() => _SortiesState();
}

class _SortiesState extends State<Sorties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bleuPrincipale,
        elevation: 0.0,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Sorties",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        actions: [
          IconButton(
              icon:Icon(Icons.search,color:Colors.white)
          ),
          IconButton(
              icon:Icon(Icons.list,color:Colors.white)
          ),
        ],
      ),
    );
  }
}
