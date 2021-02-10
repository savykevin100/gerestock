import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/authentification/inscription.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/pages/payement/select_payement_mode.dart';
import 'package:gerestock/pages/payement/select_test_mode_or_payement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentification/connexion.dart';




class SplashScreen extends StatefulWidget {
  static String emailEntreprise;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool activeTestMode;
  bool activeAbonnement;
  DateTime dateBeginTestMode;
  DateTime dateBeginAbonnement;
  String formule;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void>  getAbonnementInfos(String email){
    print("ABonnement chekc");
    Firestore.instance.collection("Utilisateurs").doc(email).collection("Abonnement").get().then((value) {
     value.docs.forEach((element) {
       setState(() {
         activeTestMode = element.data()["activeTestMode"];
         activeAbonnement = element.data()["activeAbonnement"];
         dateBeginTestMode =DateTime.parse( element.data()["dateBeginTestMode"]);
         dateBeginAbonnement = element.data()["dateBeginAbonnement"];
         formule = element.data()["formule"];
       });
       print(activeTestMode);
       print(dateBeginTestMode);
       print(dateBeginTestMode.add(Duration(minutes: 2)).toString());

       print(DateTime.now().isBefore(dateBeginTestMode.add(Duration(minutes: 2))));
     });
    });
  }


  bool currentUser=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value){
      if(value!=null){
        setState(()  {
          currentUser=true;
          SplashScreen.emailEntreprise = value.email;
        });
        getAbonnementInfos(value.email);
      }
    });
    StarTimer();
  }
  // ignore: non_constant_identifier_names
  StarTimer() async {
    var duration = Duration(seconds: 8);
    return Timer(duration, route);
  }

  route () async {
    if(currentUser == false) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Inscription()
      ));
    }
   else if(currentUser && activeTestMode && DateTime.now().isBefore(dateBeginTestMode.add(Duration(days: 30))) && !activeAbonnement) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Mode", "Test mode");
      pref.setString("Debut", dateBeginTestMode.toString());
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Accueil()
      ));
    } else if(currentUser && activeTestMode && !DateTime.now().isBefore(dateBeginTestMode.add(Duration(days: 30))) && !activeAbonnement) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => SelectPayementMode()
      ));
    } else if(currentUser && !activeTestMode && activeAbonnement && DateTime.now().isBefore(dateBeginAbonnement.add(Duration(days: 365)))){
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Mode", "Test mode");
      pref.setString("Debut", dateBeginAbonnement.toString());
      pref.setString("Formule", dateBeginAbonnement.toString());
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Accueil()
      ));
    } else if(currentUser && activeAbonnement && !activeTestMode && !DateTime.now().isBefore(dateBeginAbonnement.add(Duration(days: 365)))){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => SelectPayementMode()
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
    );
  }


}