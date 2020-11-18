import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/inventaire/nouvelInventaire.dart';


class Inventaire extends StatefulWidget {
  @override
  _InventaireState createState() => _InventaireState();
}

class _InventaireState extends State<Inventaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Inventaire"),
      body:Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context,  i) {
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              child: TextClasse(text: "03/10", family: "MonserratMedium", fontSize: 11, color: white,),
                              backgroundColor: HexColor("#B2C40F"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: TextClasse(
                                text: "Alimentaire",
                                family: "MonserratSemiBold",
                              ),
                            ),
                            SizedBox(height: 40,),
                          ],
                        ),
                        Row(
                           crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.calendar_today, size: 13,),
                            TextClasse(text: "15 Jan 2020", color: HexColor("#ADB3C4"), family: "MonserratMedium", fontSize: 10,),
                            Icon(Icons.navigate_next, size: 13,),
                          ],
                        )
                      ],
                    ),
                    Divider(color: HexColor("#ADB3C4"),)
                  ],
                );
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NouvelInventaire()));
        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
}