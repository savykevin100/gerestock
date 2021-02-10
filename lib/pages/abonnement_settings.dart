import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/payement/select_payement_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AbonnementSettings extends StatefulWidget {
  @override
  _AbonnementState createState() => _AbonnementState();
}

class _AbonnementState extends State<AbonnementSettings> {


  bool isSwitched = false;
  String mode;
  String dateDebut;
  String formule;
  String fin;

  void getAbonnementSetting() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      mode = pref.getString("Mode");
      dateDebut = pref.getString("Debut");
      if(mode == "Test mode")
        fin = DateTime.parse(dateDebut).add(Duration(days: 30)).toString();
       else
        fin = DateTime.parse(dateDebut).add(Duration(days: 355)).toString();

      if(pref.containsKey("Debut"))
      formule = pref.getString("Formule");
      else
        formule ="";
      print(dateDebut);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAbonnementSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,"Abonnement"),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#C9C9C9"),width: 5.0),
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    color: HexColor("#092648")
                  ),
                  height: 120,
                  width: 120,
                  child: Icon(Icons.person, color: white, size: 70,),
                ),
              ),
              Positioned(
                bottom: longueurPerCent(2, context),
                  left: largeurPerCent(220, context),
                  child: Container(
                      height: 25,
                      width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color:  HexColor("#B2C40F")),
                      child: Center(
                       child: TextClasse(
                  text: (mode == "Test mode")? "Test mode": formule,
                  color: white,
                  fontSize: 12,
                  family: "MonserratBold",
                  textAlign: TextAlign.center,
                )),
              ))
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextClasse(
                text: "Début :",
                color: Colors.black,
                fontSize: 15,
                family: "MonserratBold",
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 50,),
              TextClasse(
                text: dateDebut.substring(0, 19),
                color: Colors.black,
                fontSize: 15,
                family: "MonserratBold",
                textAlign: TextAlign.center,
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextClasse(
                text: "Fin : ",
                color: Colors.black,
                fontSize: 15,
                family: "MonserratBold",
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 50,),
              TextClasse(
                text: fin.substring(0, 19),
                color: Colors.black,
                fontSize: 15,
                family: "MonserratBold",
                textAlign: TextAlign.center,
              )
            ],
          ),
          SizedBox(height: longueurPerCent(20, context),),
          /*Card(
            margin: EdgeInsets.symmetric(horizontal: largeurPerCent(56, context), vertical: longueurPerCent(20, context)),
            elevation: 5.0,
            child: Container(
              height: longueurPerCent(300, context),
              width: double.infinity,
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    displayRowDetail("Nom du client", "SAVY Kévin"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:2,
                            child: TextClasse(text: "Désactivé", color: HexColor("#C9C9C9"), fontSize: 10, family: "MonserratBold",)),
                        Expanded(
                          flex: 2,
                          child:   Switch(
                              value: isSwitched,
                              onChanged: (value){
                                setState(() {
                                  isSwitched=value;
                                  print(isSwitched);
                                });
                              },
                              activeTrackColor: primaryColor,
                              activeColor: HexColor("#C9C9C9")
                          ),
                        ),
                        Expanded(
                            flex:2,
                            child: TextClasse(text: "Activé", color: HexColor("#FF0202"), fontSize: 10, family: "MonserratBold",)),
                      ],
                    ),
                    displayText("Fin de l’AbonnementSettings le 28/12/2000")
                  ],
                ),
              ),
            ),
          ),*/
          SizedBox(height: longueurPerCent(50, context),),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: largeurPerCent(10, context)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 5.0,
                        child: Container(
                          height: 120,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                height: 38,
                                width: 88,
                              color: Theme.of(context).primaryColor,
                                child: Center(
                                    child: TextClasse(
                                      text: "Test mode",
                                      color: white,
                                      fontSize: 12,
                                      family: "MonserratBold",
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              SizedBox(width: 10,),
                              SizedBox(height: 10,),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: AutoSizeText("Découvrir les fonctionnalités de l'application en mode gratuit. Ce mode est valable pour 1 mois d'utilisation.",
                                    style: TextStyle(fontSize: 15.0, fontFamily: "MonserratBold", color: HexColor("#001C36")),
                                    maxLines: 5,
                                    minFontSize: 11,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 38,
                        width: 88,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: (mode == "Test mode")?HexColor("#B2C40F"):HexColor("#C9C9C9")),
                        child: Center(
                            child: TextClasse(
                              text: "Activé",
                              color: white,
                              fontSize: 12,
                              family: "MonserratBold",
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: largeurPerCent(10, context)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 5.0,
                        child: Container(
                          height: 120,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                height: 38,
                                width: 88,
                              color: Theme.of(context).primaryColor,
                                child: Center(
                                    child: TextClasse(
                                      text: "Basique",
                                      color: white,
                                      fontSize: 12,
                                      family: "MonserratBold",
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              SizedBox(width: 10,),
                              SizedBox(height: 10,),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: AutoSizeText("Bénéficiez de toutes les fonctionnalités de l'application sans aucune aide particulière.",
                                  style: TextStyle(fontSize: 12.0, fontFamily: "MonserratBold", color: HexColor("#001C36")),
                                  maxLines: 5,
                                  minFontSize: 11,
                              ),
                                )),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 38,
                        width: 88,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: (mode !="Test mode" && formule == "Basique")?HexColor("#B2C40F"):HexColor("#C9C9C9")),
                        child: Center(
                            child: TextClasse(
                              text: (mode !="Test mode" && formule == "Basique")?"Activé":"Désactivé",
                              color: white,
                              fontSize: 12,
                              family: "MonserratBold",
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: largeurPerCent(10, context)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 5.0,
                        child: Container(
                          height: 120,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                height: 38,
                                width: 88,
                              color: Theme.of(context).primaryColor,
                                child: Center(
                                    child: TextClasse(
                                      text: "Avancé",
                                      color: white,
                                      fontSize: 12,
                                      family: "MonserratBold",
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              SizedBox(width: 10,),
                              SizedBox(height: 10,),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: AutoSizeText("Bénéficiez de toutes les fonctionnalités de l'application avec l'apport de l'aide d'un consultant dans tous les cas d'utilisation. ",
                                    style: TextStyle(fontSize: 12.0, fontFamily: "MonserratBold", color: HexColor("#001C36")),
                                    maxLines: 5,
                                    minFontSize: 11,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 38,
                        width: 88,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: (mode !="Test mode" && formule == "Avancé")?HexColor("#B2C40F"):HexColor("#C9C9C9")),
                        child: Center(
                            child: TextClasse(
                              text: (mode !="Test mode" && formule == "Avancé")?"Activé":"Désactivé",
                              color: white,
                              fontSize: 12,
                              family: "MonserratBold",
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),
              (mode == "Test mode")?submitButton(context, "Quittez le mode test", (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SelectPayementMode()));
              }):Container(),

              SizedBox(height: longueurPerCent(20, context),),

            ],
          )
        ],
      ),
    );
  }

  Widget displayRowDetail(String titre, String champResult){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex:2,
          child: AutoSizeText(
            "$titre:",
            style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("#C9C9C9")),
            maxLines: 1,
            minFontSize: 8,
          ),),
        Expanded(
          flex: 3,
          child: AutoSizeText(
            "$champResult",
            style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("#001C36")),
            maxLines: 2,
            minFontSize: 8,
          ),
        )
      ],
    );
  }
}

