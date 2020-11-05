import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
class Entrees extends StatefulWidget {
  @override
  _EntreesState createState() => _EntreesState();
}

class _EntreesState extends State<Entrees> {
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
        title: Text("Entrées",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
