import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/abonnement.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../accueil.dart';

class SelectPayementMode extends StatefulWidget {
  @override
  _SelectPayementModeState createState() => _SelectPayementModeState();
}

class _SelectPayementModeState extends State<SelectPayementMode> {

  String _emailEntreprise;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  String formule;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value){
      if(value!=null){
        setState(()  {
          _emailEntreprise = value.email;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  formule = "Basique";
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  KKiaPay(
                    amount: 100000,
                    phone: '61000000',
                    data: 'hello world',
                    sandbox: true,
                    apikey: '1b28e1d0772911eaa95c41ede0b15bcd',
                    callback: sucessCallback,
                    name: 'JOHN DOE',
                    theme: ("#3675BD"),
                  )),
                );
              },
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: longueurPerCent(200, context),
                  child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5,),
                        Container(
                          height: 38,
                          width: 88,
                          color: bleuPrincipale,
                          child: Center(
                              child: TextClasse(
                                text: "Basique",
                                color: white,
                                fontSize: 15,
                                family: "MonserratBold",
                                textAlign: TextAlign.center,
                              )),
                        ),
                        SizedBox(height: 20,),
                        AutoSizeText("Bénéficiez de toutes les fonctionnalités de l'application sans aucune aide particulière.",
                          style: TextStyle(fontSize: 15.0, fontFamily: "MonserratBold", color: HexColor("#001C36")),
                          maxLines: 6,
                          minFontSize: 10,
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                setState(() {
                  formule = "Avancé";
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  KKiaPay(
                    amount: 200000,
                    phone: '61000000',
                    data: 'hello world',
                    sandbox: true,
                    apikey: '1b28e1d0772911eaa95c41ede0b15bcd',
                    callback: sucessCallback,
                    name: 'JOHN DOE',
                    theme: ("#3675BD"),
                  )),
                );
              },
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: longueurPerCent(200, context),
                  child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5,),
                        Container(
                          height: 38,
                          width: 88,
                          color: Color(0xFFB2C40F),
                          child: Center(
                              child: TextClasse(
                                text: "Avancé",
                                color: white,
                                fontSize: 15,
                                family: "MonserratBold",
                                textAlign: TextAlign.center,
                              )),
                        ),
                        SizedBox(height: 20,),
                        AutoSizeText("Bénéficiez de toutes les fonctionnalités de l'application avec l'apport de l'aide d'un consultant dans tous les cas d'utilisation. ",
                          style: TextStyle(fontSize: 15.0, fontFamily: "MonserratBold", color: HexColor("#001C36")),
                          maxLines: 6,
                          minFontSize: 10,
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> sucessCallback(response, context) async {
    Navigator.pop(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("Mode", "Abonnement");
    pref.setString("Debut", DateTime.now().toString());
    pref.setString("Formule", formule);
    FirestoreService().addAbonnement(Abonnement(
        activeTestMode: true,
        activeAbonnement: false,
        dateBeginTestMode: DateTime.now().toString(),
        formule: formule,
    ) , _emailEntreprise);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Accueil()
      ),
    );
  }
}
