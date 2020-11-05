import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:im_stepper/stepper.dart';

import 'constantes/constantsWidgets.dart';
import 'constantes/color.dart';

class IconStepperDemo extends StatefulWidget {
  static String id="Icon";
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<IconStepperDemo> {
  // MUST BE MAINTAINED, SEPARATELY.
  int currentIndex = 0;

  // THESE MUST BE USED TO CONTROL THE STEPPER FROM EXTERNALLY.
  bool goNext = false;
  bool goPrevious = false;
  List<String> numberSelect = ["0"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextClasse(text: "Nouveau Produit", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
          backgroundColor: primaryColor,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 17,),
            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: longueurPerCent(10, context)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: largeurPerCent(60, context)),
                  child: IconStepper.externallyControlled(
                    activeStepBorderColor: Colors.white,
                    goNext: goNext,
                    goPrevious: goPrevious,
                    direction: Axis.horizontal,
                    stepColor:  (numberSelect.length==2)?secondaryColor:Colors.grey,
                    activeStepColor:secondaryColor,
                    lineColor: secondaryColor,
                    lineLength: 75,
                    scrollingDisabled: true,
                    icons: [
                      Icon(Icons.looks_one, color: Colors.white,),
                      Icon(Icons.looks_two, color: Colors.white,),
                    ],
                  ),
                )
              ),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            Center(child: header()),
            SizedBox(height: longueurPerCent(50, context),),
          ],
        ),
      ),
    );
  }

  Widget header() {
    switch (currentIndex) {
      case 0:
        return createOrSelectFamily();

      case 1:
        return createProduct();

     }
  }


  Widget createOrSelectFamily(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: longueurPerCent(20, context),),
        TextClasse(text: "Créer ou choisir une famille", color: secondaryColor, family: "MonserratBold", fontSize: 15,),
        SizedBox(height: longueurPerCent(50, context),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            nameOfFieldWithPadding("Famille", context),
            Container(
              height: longueurPerCent(41, context),
              width: largeurPerCent(210, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(width: 1.0, color: HexColor("#707070")),
              ),
              child: DropdownButton(
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                items:
                ["Véhicules court", "moto"].map(
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
            )
          ],
        ),
        SizedBox(height: longueurPerCent(50, context),),
        textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Nom de la famille", context), context),
        SizedBox(height: longueurPerCent(150, context),),
        submitButton(context, "SUIVANT", (){
          setState(() {
            goNext = true;
            if (currentIndex < 2) {
              currentIndex++;
              numberSelect.add("1");
            }
          });
        },)
      ],
    );
  }


  Widget createProduct(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: longueurPerCent(20, context),),
        Center(child: Column(
          children: [
            TextClasse(text: "Créer un nouveau produit", color: secondaryColor, family: "MonserratBold", fontSize: 15, textAlign: TextAlign.center,),
            SizedBox(height: longueurPerCent(20, context),),
            InkWell(
              child: Container(
                height: longueurPerCent(99, context),
                width: largeurPerCent(122, context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: HexColor("#707070"),)
                ),
                child: Icon(Icons.add, color: secondaryColor,),
              ),
            ),
            SizedBox(height: longueurPerCent(10, context),),
            displayText("Image")
          ],
        )),
        SizedBox(height: longueurPerCent(20, context),),
        Column(
          children: [
            textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Nom du produit", context), context),
            SizedBox(height: longueurPerCent(20, context),),
            textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Code", context), context),
            SizedBox(height: longueurPerCent(20, context),),
            textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Libellé", context), context),
            SizedBox(height: longueurPerCent(20, context),),
            textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Prix d'achat", context), context),
            SizedBox(height: longueurPerCent(20, context),),
            textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Prix de vente", context), context),
            SizedBox(height: longueurPerCent(20, context),),
            textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Stock alerte", context), context), SizedBox(height: longueurPerCent(20, context),),
            SizedBox(height: longueurPerCent(20, context),),
            submitButton(context, "SUIVANT", (){
              setState(() {
                goNext = true;
                if (currentIndex < 2) {
                  currentIndex++;
                  numberSelect.add("1");
                }
              });
            },)
          ],
        ),
      ],
    );
  }
}