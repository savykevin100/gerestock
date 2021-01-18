import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';

import 'color.dart';
import 'hexadecimal.dart';




 Widget DropdownSearchWidget(List<String> data, BuildContext context, String itemSelect, String hintText, String textInSearchBar){
  return Container(
      height: 50,
      width: largeurPerCent(210, context),
      margin: EdgeInsets.only(right: largeurPerCent(22, context)),
      child: DropdownSearch<String>(
        mode: Mode.DIALOG,
        maxHeight: 450,
        items: data.toList(),
        onChanged: (value) {
          itemSelect = value;
          print(itemSelect);
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: longueurPerCent(50, context), right: longueurPerCent(50, context)),
            hintText: hintText,
            hintStyle: TextStyle(color: HexColor("#707070"), fontFamily: "ORegular", fontSize: 15)
        ),
        popupTitle: Container(
          height: longueurPerCent(50, context),
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Center(
            child: Text(
              textInSearchBar,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        popupShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7),
            topRight: Radius.circular(7),
          ),
        ),
      )
  );
 }