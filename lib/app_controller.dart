import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AppController extends ControllerMVC {

  String userPhone = "";
  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");

  AppController(){
    numeroUser();
  }

  void numeroUser() {
    userNumero().then((value) {
      if(value!=null)
        setState(() {
          userPhone = value;

          print(userPhone);
        });
    });

  }

  void fetchProductsInFamily(familyName, List<Map<String, dynamic>> productsList){
    numeroUser();
    _users
        .doc(userPhone)
        .collection("TousLesProduits")
        .where("familyName", isEqualTo: familyName)
        .get().then((value){
      value.docs.forEach((element) {
          setState(() {
            productsList.add(element.data());
          });
      });
    });
  }


}