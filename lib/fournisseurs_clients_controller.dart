import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FournisseursClientsController extends ControllerMVC {

  String userPhone = "";
  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");

  FournisseursClientsController(){
    numeroUser();
  }

  void numeroUser() {
    userNumero().then((value) {
      if(value!=null)
        setState(() {
          userPhone = value;

        });
    });
    print("Le user phone est");
    print(userPhone);
  }

}