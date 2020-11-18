import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/nouveauProduit/ficheProduit.dart';


class ProduitsFamille extends StatefulWidget {
  @override
  _ProduitsFamilleState createState() => _ProduitsFamilleState();
}

class _ProduitsFamilleState extends State<ProduitsFamille> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Produits"),
      body: Center(
        child:  Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context,  i) {
                return Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => FicheProduit()));
                      },
                      child: ListTile(
                        title: TextClasse(
                          text: "Huile",
                          family: "MonserraLight",
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          color: HexColor("#ADB3C4"),
                          size: 30,
                        ),
                      ),
                    ),
                    Divider(color: HexColor("#ADB3C4"),)
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}
