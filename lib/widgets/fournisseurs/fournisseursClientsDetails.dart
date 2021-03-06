import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/modeles/clients_fournisseurs.dart';

import 'fournisseursClientsModify.dart';


// ignore: must_be_immutable
class FournisseursClientsDetails extends StatefulWidget {

  String title;
  ClientsFounisseursModel clientsFouniss = ClientsFounisseursModel();
  FournisseursClientsDetails({this.clientsFouniss, this.title});


  @override
  _FournisseursClientsDetailsState createState() => _FournisseursClientsDetailsState();
}

class _FournisseursClientsDetailsState extends State<FournisseursClientsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,"Profil"),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(50, context),),
          Icon(Icons.person, color: primaryColor, size: 100,),
          Card(
            margin: EdgeInsets.symmetric(horizontal: largeurPerCent(56, context), vertical: longueurPerCent(20, context)),
            elevation: 5.0,
            child: Container(
              height: longueurPerCent(300, context),
              width: double.infinity,
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    displayRowDetail("Nom du client",widget.clientsFouniss.name),
                    displayRowDetail("Adresse", widget.clientsFouniss.address),
                    displayRowDetail("Téléphone", widget.clientsFouniss.telephoneNumber),
                    displayRowDetail("Email", widget.clientsFouniss.email),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: longueurPerCent(50, context),),
          submitButton(context, "MODIFIER", (){
            print(widget.title);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ModifyClientOrFournisseur(title: widget.title, clientsFouniss: widget.clientsFouniss,)));
          })
        ],
      ),
    );
  }

  Widget displayRowDetail(String titre, String champResult){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex:2,
          child: AutoSizeText(
            "$titre:",
            style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("#C9C9C9")),
            maxLines: 1,
            minFontSize: 8,
          ),),
        Expanded(
          flex: 3,
          child: AutoSizeText(
            "$champResult",
            style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("#001C36")),
            maxLines: 2,
            minFontSize: 8,
          ),
        )
      ],
    );
  }
}
