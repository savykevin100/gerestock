import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/pages/payement/select_payement_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomDialog.dart';
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

 // AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();



  // Platform messages are asynchronous, so we initialize in an async method.
 /* Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) => _showError(e));
  }

  void _showError(dynamic exception) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(exception.toString())));
  }*/



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

  route () async {    if(currentUser == false) {

     /* if(_updateInfo.updateAvailable==false){
        showUpdateDialog();
      } else
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Connexion()
        ));*/

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Connexion()
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
      backgroundColor: Colors.white,
     body: Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(
         image: DecorationImage(
           image:AssetImage("lib/assets/images/gerestock_logo.jpg",),
           fit: BoxFit.contain
         )
       ),
     )
    );
  }



  void showUpdateDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Mise à jour",
        description:
        "Une nouvelle mise à jour est disponilble, voulez-vous la télécharger maintenant?",
        cancelButton: FlatButton(
          onPressed: (
              ) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Accueil()));
          },
          child: Text("Plus tard",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12.0,
                fontFamily: "MonseraBold"
            ),
          ),
        ),
        nextButton: FlatButton(
          onPressed: (
              ) {
            Navigator.pop(context);
           // InAppUpdate.performImmediateUpdate().catchError((e) => _showError(e));
          },
          child: Text("Oui",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12.0,
                fontFamily: "MonseraBold"
            ),),
        ),
        icon: Icon(Icons.system_update,size: 100,  color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

}