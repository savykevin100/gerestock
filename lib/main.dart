import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/authentification/connexion.dart';
import 'package:gerestock/authentification/inscription.dart';
import 'package:gerestock/pages/abonnement.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/pages/caisse/caisse.dart';
import 'package:gerestock/pages/caisse/encaissement.dart';
import 'package:gerestock/pages/clients/clients.dart';
import 'package:gerestock/pages/clients/ficheClient.dart';
import 'package:gerestock/pages/caisse/decaissement.dart';
import 'package:gerestock/pages/depenses/depenses.dart';
import 'package:gerestock/pages/depenses/nouvelleDepense.dart';
import 'package:gerestock/pages/mouvementsDeStock/confirmEntrees.dart';
import 'package:gerestock/pages/mouvementsDeStock/entrees.dart';
import 'package:gerestock/pages/facturations/facturation1.dart';
import 'package:gerestock/pages/facturations/facturation2.dart';
import 'package:gerestock/pages/fournisseurs/ficheFournisseur.dart';
import 'package:gerestock/pages/fournisseurs/fournisseurs.dart';
import 'package:gerestock/pages/inventaire/inventaire.dart';
import 'package:gerestock/pages/mouvementsDeStock/mouvementDeStock.dart';
import 'package:gerestock/pages/nouveauProduit/familles.dart';
import 'package:gerestock/pages/nouveauProduit/nouveauProduit.dart';
import 'package:gerestock/pages/parametres.dart';
import 'package:gerestock/pages/mouvementsDeStock/sorties.dart';
import 'package:gerestock/spash_screen.dart';
import 'package:gerestock/test.dart';

import 'pages/mouvementsDeStock/ficheEntrees.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerestock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder> {
        '/inscription': (BuildContext context) => Inscription(),
        '/connexion': (BuildContext context) => Connexion(),
        '/accueil': (BuildContext context) =>Accueil(),
        '/Clients': (BuildContext context) => Clients(),
        '/FicheClient': (BuildContext context) => FicheClient(),
        '/Produits': (BuildContext context) => Produits(),
        '/Fournisseur': (BuildContext context) => Fournisseurs(),
        '/FicheFournisseur': (BuildContext context) => FicheFournisseur(),
        '/Mouvement de Stock': (BuildContext context) => MouvementDeStock(),
        '/Facturation': (BuildContext context) => Facturation1(),
        '/Facturation2': (BuildContext context) => Facturation2(),
        '/Caisse': (BuildContext context) => Caisse(),
        '/Inventaire': (BuildContext context) => Inventaire(),
        '/Abonnement': (BuildContext context) => Abonnement(),
        '/Dépenses': (BuildContext context) => Depenses(),
        '/Paramètres': (BuildContext context) => Parametres(),
        '/Entrées': (BuildContext context) => Entrees(),
        '/Sorties': (BuildContext context) => Sorties(),
        '/Encaissement': (BuildContext context) => Encaissement(),
        '/Décaissement': (BuildContext context) => Decaissement(),
        '/FicheEntrees': (BuildContext context) => FicheEntrees(),
        '/ConfirmEntrees': (BuildContext context) => ConfirmEntrees(),
        '/NouvelleDepense': (BuildContext context) => NouvelleDepense(),
        '/HomePage': (BuildContext context) => HomePage(),
        '/SpashScreen': (BuildContext context) => SplashScreen(),
      },
      builder: (BuildContext context, Widget child) {
        /// make sure that loading can be displayed in front of all other widgets
        return FlutterEasyLoading(child: child);
      },
    );
  }
}

