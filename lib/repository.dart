import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setNumeroUser(String numero) async {
  if (numero != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('numero_user', numero);
  }
}


Future<String> userNumero() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String numero_user = null;
  if (prefs.containsKey('numero_user')) {
    numero_user = await prefs.get('numero_user').toString();
  }
  return numero_user;
}


