import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/authentification/inscription.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/pages/payement/select_test_mode_or_payement.dart';




class SplashScreen extends StatefulWidget {
  static String emailEntreprise;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
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
      }
    });
    StarTimer();
  }
  // ignore: non_constant_identifier_names
  StarTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route (){
    if(currentUser ){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Accueil()
      ));
    } else{
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Inscription()
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