
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';

import 'hexadecimal.dart';




/*Color primaryColor = HexColor("#3675BD");
Color secondaryColor = HexColor("#B2C40F");
Color textColor = HexColor("#001C36");
Color white = Colors.white;*/


  TextClasse  displayText(String text){
   return TextClasse(text: text, color: textColor, family: "MonserratBold", fontSize: 12,);
  }


 Widget textFieldWidgetWithNameOfField(Widget nameField, BuildContext context, TextEditingController controller, TextInputType inputType){
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
       nameField,
       Container(
         height: 41,
         width: largeurPerCent(210, context),
         margin: EdgeInsets.only(right: largeurPerCent(22, context)),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(3),
           border: Border.all(width: 1.0, color: HexColor("#707070")),
         ),
         child: TextField(
           style: TextStyle(fontSize: 15, fontFamily: "MonserratSemiBold"),
           keyboardType: inputType,
           maxLines: null,
           controller: controller,
           decoration: InputDecoration(
             contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
               enabledBorder: InputBorder.none
           ),
         ),
       )
     ],
   );
 }


Widget nameOfFieldWithPadding(String nameField, BuildContext context){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
    child: displayText(nameField),
  );
}

  double heightScreen(BuildContext context) {
    return  MediaQuery.of(context).size.height;
  }

  double widthScreen(BuildContext context) {
    return  MediaQuery.of(context).size.width;
  }
