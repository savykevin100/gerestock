import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';


class NouvelInventaire extends StatefulWidget {
  @override
  _NouvelInventaireState createState() => _NouvelInventaireState();
}

class _NouvelInventaireState extends State<NouvelInventaire> {
  String dateInput;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Nouvel Inventaire"),
      body: ListView(
        children: [
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Date de réception", context),
              InkWell(
                onTap: (){
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2040, 12, 31), onChanged: (date) {
                        setState(() {
                          dateInput = date.toString().substring(0, 10);
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          dateInput = date.toString().substring(0, 10);
                          print(dateInput);
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.fr);
                },
                child: Container(
                    height: longueurPerCent(41, context),
                    width: largeurPerCent(210, context),
                    margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1.0, color: HexColor("#707070")),
                    ),
                    child: (dateInput!=null)?Center(child: TextClasse(text: dateInput, color:  HexColor("#707070"), family: "MonserratBold",),):Text("")
                ),
              )
            ],
          ),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Famille du produit", context),
              InkWell(
                onTap: (){

                },
                child: Container(
                  height: longueurPerCent(41, context),
                  width: largeurPerCent(210, context),
                  margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(width: 1.0, color: HexColor("#707070")),
                  ),
                  child:  DropdownButton(
                    underline: Text(""),
                    hint: "" == null
                        ? Text(
                      'Payement',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                        : Text(
                      "",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    items:
                    ["SAVY Kévin", "Jean de dieu Houbgelo"].map(
                          (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val,),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {

                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 40,),
          TextClasse(text: "Liste des produits", textAlign: TextAlign.center, family: "MonserratBold", color: HexColor("#001C36"),),

        ],
      )
    );
  }
}
