import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/constantes/appBar.dart';
class FicheEntrees extends StatefulWidget {

  @override
  _FicheEntreesState createState() => _FicheEntreesState();
}

class _FicheEntreesState extends State<FicheEntrees> {

  String dateInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarWithSearch(context,"Entrées"),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          TextClasse(text: "Nouvelle entrée",color: Colors.black,fontSize: 30,textAlign: TextAlign.center, family: "MonserratBold"),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Date de réception", context),
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
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("N° de bordereau", context), context),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Fournisseur", context),
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
          SizedBox(height: longueurPerCent(20, context),),
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Livreur", context), context),
          SizedBox(height: longueurPerCent(100, context),),
          submitButton(context, "CONTINUER", (){
            Navigator.of(context).pushNamed("/ConfirmEntrees");
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
