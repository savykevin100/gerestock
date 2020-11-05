import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';

import 'facturation2.dart';

class Facturation1 extends StatefulWidget {
  static String id = "Facturation1";
  @override
  _Facturation1State createState() => _Facturation1State();
}

class _Facturation1State extends State<Facturation1> {

  String dateInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextClasse(text: "Facturation", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             nameOfFieldWithPadding("Date", context),
             InkWell(
               onTap: (){
                 DatePicker.showDatePicker(context,
                     showTitleActions: true,
                     minTime: DateTime(1900, 1, 1),
                     maxTime: DateTime(2018, 6, 7), onChanged: (date) {
                       setState(() {
                         dateInput = date.toString().substring(0, 10);
                         print(dateInput);
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
         textFieldWidgetWithNameOfField(nameOfFieldWithPadding("N° de la facture", context), context),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Client", context),
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
          SizedBox(height: 56,),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    displayRecapTextBold("Nom du produit"),
                    displayRecapTextBold("Entrées"),
                    Padding(
                      padding: EdgeInsets.only(right: 55),
                      child: displayRecapTextBold("Quantité"),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 1,
                    itemCount: 2,
                    itemBuilder: (context, i) {
                      return Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: longueurPerCent(31, context),
                                  width: largeurPerCent(100, context),
                                  margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(width: 1.0, color: HexColor("#707070")),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none
                                    ),
                                  ),
                                ),
                                Container(
                                  height: longueurPerCent(31, context),
                                  width: largeurPerCent(100, context),
                                  margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(width: 1.0, color: HexColor("#707070")),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: longueurPerCent(31, context),
                                    width: largeurPerCent(100, context),
                                    margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(width: 1.0, color: HexColor("#707070")),
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 0.0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                )
              ],
            ),
          ),
             SizedBox(height: longueurPerCent(100, context),),
             submitButton(context, "GENERER", (){
               Navigator.of(context).pushNamed("/Facturation2");

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
