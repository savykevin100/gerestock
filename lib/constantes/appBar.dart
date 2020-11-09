import 'package:flutter/material.dart';
import 'package:gerestock/constantes/text_classe.dart';

import 'color.dart';


AppBar appBar(BuildContext context,String titre){
  return AppBar(
    leading:IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),
      onPressed: (){
        Navigator.pop(context);
      },),
    title: TextClasse(text: titre, color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
    backgroundColor: primaryColor,
  );
}


AppBar appBarWithSearch(BuildContext context,String titre){
  return AppBar(
    backgroundColor: bleuPrincipale,
    elevation: 0.0,
    leading:IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),
    onPressed: (){
      Navigator.pop(context);
    },),
    title: TextClasse(text: titre, color: white, fontSize: 20, family: "MonserratBold",),
    actions: [
      IconButton(
          icon:Icon(Icons.search,color:Colors.white)
      ),
      IconButton(
          icon:Icon(Icons.list,color:Colors.white)
      ),
    ],
  );
}