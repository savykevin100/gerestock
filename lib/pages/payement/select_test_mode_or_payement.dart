import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/modeles/abonnement.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/pages/payement/select_payement_mode.dart';


class TestModeOrPayement extends StatefulWidget {
  @override
  _TestModeOrPayementState createState() => _TestModeOrPayementState();
}

class _TestModeOrPayementState extends State<TestModeOrPayement> {
  String _emailEntreprise;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }



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
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                  try {
                   if(_emailEntreprise!=null)
                     FirestoreService().addAbonnement(Abonnement(
                         activeTestMode: true,
                         activeAbonnement: false,
                         dateBeginTestMode: DateTime.now().toString()
                     ) , _emailEntreprise);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Accueil()
                    ));
                  } catch (e){
                    print(e);

                    // On affiche le message veuillez vérifier la connexion internet
                  }

                  },
                  child: _buildCard("lib/assets/images/free.png", "Découvrir les fonctionnalités de l'application en mode gratuit. Ce mode est valable pour 1 mois d'utilisation.", "Mode test")
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SelectPayementMode()
                    ));
                  },
                    child: _buildCard("lib/assets/images/cash_payment.png", "Bénéficiez des fonctionnalités qui seront disponibles pendant 1 an et en fonction du pack de payement choisi vous pouvez "
                        "bénéficier d'une aide en fonction des problèmes rencontrés au cours de l'utilisation de l'application", "Mode Abonnement")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCard(String imgPath, String text, String title) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            child: Container(
              height: 150,
              width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Text(title,
                        style: TextStyle(fontSize: 20.0, fontFamily: "MonserratBold", color: Colors.red),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(imgPath),
                                      fit: BoxFit.contain))),
                          SizedBox(width: 20,),
                          Expanded(
                            flex: 2,
                            child: Text(text,
                              style: TextStyle(fontSize: 12.0, fontFamily: "MonserratBold", color: bleuPrincipale),
                              maxLines: 7,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ))));
  }


  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle( color: HexColor("#001C36"),
            fontSize: 15.0,
            fontFamily: "MonseraBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NON", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),

          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("OUI", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }

}
