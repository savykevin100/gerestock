import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';





class Fournisseurs extends StatefulWidget {
  static String id = "Fournisseurs";
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Fournisseurs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Fournisseurs"),
      body: Center(
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: largeurPerCent(21, context), vertical: longueurPerCent(46, context)),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context,  i) {
                    return Column(
                      children: [
                        ListTile(
                          title: TextClasse(
                            text: "Nom du fournisseur",
                            family: "MonserratSemiBold",
                          ),
                          subtitle: TextClasse(text: "68 68 68 68", family: "MonserratMedium", fontSize: 13,),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: HexColor("#ADB3C4"),
                            size: 30,
                          ),
                        ),
                        Divider(color: HexColor("#ADB3C4"),)
                      ],
                    );
                  }
              ),
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/FicheFournisseur");

        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
}
