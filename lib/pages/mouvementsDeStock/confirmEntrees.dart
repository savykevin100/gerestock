import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';

class ConfirmEntrees extends StatefulWidget {
  @override
  _ConfirmEntreesState createState() => _ConfirmEntreesState();
}

class _ConfirmEntreesState extends State<ConfirmEntrees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context,"Entrées"),
      body: ListView(
        children: [
          Card(
            elevation: 3.0,
            child: Column(
              children: [
                SizedBox(height: longueurPerCent(20, context),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    nameOfFieldWithPadding("Nom du produit", context),
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
                textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Quantité", context), context),
                SizedBox(height: longueurPerCent(20, context),),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bleuPrincipale,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
