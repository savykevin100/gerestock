import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerestock/authentification/connexion.dart';
import 'package:gerestock/authentification/inscription.dart';
import 'package:gerestock/pages/abonnement.dart';
import 'package:gerestock/pages/acceuil.dart';
import 'package:gerestock/pages/caisse.dart';
import 'package:gerestock/pages/clients.dart';
import 'package:gerestock/pages/depenses.dart';
import 'package:gerestock/pages/entrees.dart';
import 'package:gerestock/pages/facturation.dart';
import 'package:gerestock/pages/fournisseur.dart';
import 'package:gerestock/pages/inventaire.dart';
import 'package:gerestock/pages/mouvementDeStock.dart';
import 'package:gerestock/pages/nouveauProduit.dart';
import 'package:gerestock/pages/parametres.dart';
import 'package:gerestock/pages/sorties.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerestock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Accueil(),
      routes: <String, WidgetBuilder> {
        '/inscription': (BuildContext context) => Inscription(),
        '/connexion': (BuildContext context) => Connexion(),
        '/acceuil': (BuildContext context) =>Accueil(),
        '/Clients': (BuildContext context) => Clients(),
        '/Nouveau Produit': (BuildContext context) => NouveauProduit(),
        '/Fournisseur': (BuildContext context) => Fournisseur(),
        '/Mouvement de Stock': (BuildContext context) => MouvementDeStock(),
        '/Facturation': (BuildContext context) => Facturation(),
        '/Caisse': (BuildContext context) => Caisse(),
        '/Inventaire': (BuildContext context) => Inventaire(),
        '/Abonnement': (BuildContext context) => Abonnement(),
        '/Dépenses': (BuildContext context) => Depenses(),
        '/Paramètres': (BuildContext context) => Parametres(),
        '/Entrées': (BuildContext context) => Entrees(),
        '/Sorties': (BuildContext context) => Sorties(),
      },
    );
  }
}

