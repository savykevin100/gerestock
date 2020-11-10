import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';

class NouvelleDepense extends StatefulWidget {
  @override
  _NouvelleDepenseState createState() => _NouvelleDepenseState();
}

class _NouvelleDepenseState extends State<NouvelleDepense> {
  String dateInput;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Dépenses"),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          TextClasse(text: "Nouvelle dépense",color: Colors.black,fontSize: 30,textAlign: TextAlign.center, family: "MonserratBold"),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: nameOfFieldWithPadding("Date de l'opération", context)),
              InkWell(
                onTap: (){
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
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
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Numéro", context), context),
          SizedBox(height: longueurPerCent(20, context),),
          Flexible(child: textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Dépense", context), context)),
          SizedBox(height: longueurPerCent(20, context),),
          Flexible(child: textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Montant", context), context)),
          SizedBox(height: longueurPerCent(100, context),),
          submitButton(context, "ENREGISTRER", (){
            //Navigator.of(context).pushNamed("/ConfirmEntrees");
          })
        ],
      ),
    );
  }
  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }
}
