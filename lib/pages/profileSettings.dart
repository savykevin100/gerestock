import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gerestock/authentification/connexion.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/pages/parametres.dart';

import 'accueil.dart';
import 'chat.dart';
import 'nouveauProduit/familles.dart';


// ignore: must_be_immutable
class ProfileSettings extends StatefulWidget {


  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _auth = FirebaseAuth.instance;
  bool chargement=false;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //creationHeader(),
          SizedBox(height: 100,),

          drawerItem(
              icon: Icons.home,
              text: "Accueil",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Accueil()));
              }),
          drawerItem(
              icon: Icons.person,
              text: "Paramètres",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Parametres()));
              }),
          drawerItem(
              icon: Icons.chat,
              text: "Chat",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              }),
          drawerItem(
              icon: Icons.share,
              text: "Partager l'application",
              onTap: () {
               // _shareImageFromUrl();

              }),
          SizedBox(height: 50,),
          Divider(),
          drawerItem(
              icon: Icons.library_books,
              text: "Conditions Générales",
              onTap: () {
                /*Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ConditionGenerales()));*/
              }),
          drawerItem(
              icon: Icons.info,
              text: "À propos",
              onTap: () {

                /*Navigator.push(
                    context, MaterialPageRoute(builder: (context) => APrpos()));*/
              }),
          drawerItem(
              icon: Icons.logout,
              text: "Deconnexion",
              onTap: () async {
                await _auth.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Connexion()));
              }),
        ],
      ),
    );
  }

 /* Widget creationHeader(String currentUser) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: HexColor('#001C36'),
      ),
      otherAccountsPictures: <Widget>[],
      accountName: StreamBuilder(
          stream:  FirestoreService().getUtilisateurs(),
          builder: (BuildContext context, AsyncSnapshot<List<Utilisateur>> snapshot) {
            if(snapshot.hasError || !snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              for(int i=0; i<snapshot.data.length; i++) {
                Utilisateur utilisateur = snapshot.data[i];
                if(utilisateur.email == currentUser) {
                  donneesUtilisateurConnecte = utilisateur;
                }
              }

              return Text("${donneesUtilisateurConnecte.nomComplet}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold));
            }
          }
      ),
      accountEmail: Text(currentUser, style: TextStyle(fontSize: 15)),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: Text(
            widget.firstLetter,
            style: TextStyle(color: HexColor("#001c36"), fontSize: 50,fontWeight: FontWeight.bold),
          ),
        ),),
    );
  }*/

  Widget drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          (chargement && text=="Partager l'application")?CircularProgressIndicator(): Icon(
            icon,
            color:Theme.of(context).primaryColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                  color: HexColor('#001C36'),
                  fontSize: 16.0,
                  fontFamily: 'Regular'),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  /*Future<void> _shareImageFromUrl() async {
    try {
      setState(() {
        chargement=true;
      });
      var request = await HttpClient().getUrl(Uri.parse(
          "https://firebasestorage.googleapis.com/v0/b/marketeurfollomme.appspot.com/o/Untitled-2.jpg?alt=media&token=a1cbb03c-1e96-4fb7-b3e3-184f3c387f0e"));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Partager', 'amlog.jpg', bytes, 'image/jpg', text: "Hey! T'as déjà la nouvelle appli tendance de vente de vêtements de friperie? Sinon"
          " Télécharge la shap shap: https://play.google.com/store/apps/details?id=com.followme.premierchoix");
      setState(() {
        chargement=false;
      });
    } catch (e) {
      print('error: $e');
    }
  }*/
}